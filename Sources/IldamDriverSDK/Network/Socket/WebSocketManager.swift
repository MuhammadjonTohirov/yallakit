//
//  File.swift
//  YallaKit
//
//  Created by applebro on 28/05/25.
//

import Foundation
import NetworkLayer
import Starscream

public protocol WebSocketDelegateHandler: AnyObject {
    func didReceive<T: NetResBody>(channel: WebSocketOrderChannels, message: SocketRes<T>)
    func didDisconnect(error: Error?)
    func didConnect()
}

public protocol WebSocketChannelHandler: AnyObject {
    func onReceiveOrdersMe(_ response: ActiveOrderListResponse)
    func onReceiveMe(_ response: ExecutorMeResponse)
    func onReceiveInfo(_ response: ExecutorMeResponse)
    
    func onReceiveOrdersEther(_ response: OrderListResponse)
    func onReceiveOrderSendToEther(_ response: [OrderSentToExecutorResponse])
    func onReceiveOrderSendToExecutorFromNonStop(_ response: OrderSentToExecutorResponse )
    func onReceiveOrderSendToExecutor(_ response: OrderSentToExecutorResponse)
    func onReceiveOrderAppointToExecutor(_ response: OrderSentToExecutorResponse)
    
    func onReceiveOrderRemoveFromEther(_ response: OrderRemoveFromAppointedExecutorResponse)
    func onReceiveOrderRemoveFromExecutor(_ response:OrderRemoveFromAppointedExecutorResponse)
    func onReceiveOrderRemoveFromAppointedExecutor(_ response:OrderRemoveFromAppointedExecutorResponse)

    func onReceiveOrderUpdate(_ response: OrderUpdateSocketResponse)
    func onReceiveOrderUpdateFromEther(_ response: OrderSentToEtherResponse)

    func onReceiveStatusUpdateFromPanel(_ response: OrderStatusUpdateFromPanelResponse)
    func onReceiveOrderStatusUpdate(_ response: OrderStatusUpdateFromPanelResponse)

    func onReceiveOrderShow(_ response: OrderShowResponse)
    func onReceiveOrderSkip()
    
    func onReceiveOrderAppointFromOffer(_ response: OrderAppointedResponse)
    func onReceiveOrderAppoint(_ response: OrderAppointedResponse)
    
    func onReceiveOrderCompletedFromPanel(_ response: OrderCompletedFromPanel)
    func onReceiveOrderComplete(_ response: OrderCompletedFromPanel)
    
    func onReceiveOrderCanceledFromClient(_ response: OrderCanceledFromPanelResponse)
    func onReceiveOrderCanceledFromPanel(_ response: OrderCanceledFromPanelResponse)
    func onReceiveOrderCancel(_ response: OrderCanceledFromPanelResponse)
    
    func onReceiveTariffConfigs(_ response: OrderTariffConfigurationResponse)
    
    func onReceiveCurbDefault(_ response: DriverDefaultTariffResponse)
    func onReceiveCurbCreate(_ response:  DriverCrubResponse)
    
    func onReceiveBalanceIncome(_ response: ExecutorMeResponse)
    func onReceiveBalanceExpense(_ response: ExecutorMeResponse)
    func onReceiveBalance(_ response: ExecutorMeResponse)
    
    func onReceiveFotocontrol(_ response: ExecutorMeResponse)
    
    func onReceiveGetCondition(_ response: DriverGetConditionResponse)
    func onReceiveCondition(_ response:DriverGetConditionResponse)
    func onReceivePanelCondition(_ response:DriverGetConditionResponse)
}

public final class WebSocketManager: WebSocketDelegate {
    @MainActor public static let shared = WebSocketManager()
    private var socket: WebSocket?
    private var isConnected: Bool = false
    private var token: String?
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    public weak var delegate: WebSocketDelegateHandler?
    public weak var channelDelegate: WebSocketChannelHandler?

    private init() {}

    public func configure(token: String) {
        self.token = token
        var request = URLRequest(url: URL(string: "wss://api2.ildam.uz/ws/executor?token=\(token)")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.respondToPingWithPong = true
    }

    public func connect() {
        guard let socket = socket, !isConnected else { return }
        socket.connect()
    }

    public func disconnect() {
        socket?.disconnect()
    }

    public func send<T: Encodable>(_ data: T) {
        do {
            let jsonData = try encoder.encode(data)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                socket?.write(string: jsonString)
            }
        } catch {
            print("[WebSocket] Failed to encode data: \(error)")
        }
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(_):
            isConnected = true
            delegate?.didConnect()

        case .disconnected(let reason, let code):
            isConnected = false
            Logging.l("[WebSocket] Disconnected: \(reason) (code: \(code))")
            delegate?.didDisconnect(error: WSError(type: .serverError, message: reason, code: code))

        case .text(let text):
            handleIncoming(text: text)
        case .binary(let data):
            Logging.l("[WebSocket] Received binary data of size: \(data.count)")

        case .error(let error):
            isConnected = false
            Logging.l("[WebSocket] Error: \(String(describing: error))")
            delegate?.didDisconnect(error: error)

        case .cancelled:
            isConnected = false
            Logging.l("[WebSocket] Connection cancelled")
            delegate?.didDisconnect(error: nil)

        case .pong(_), .ping(_), .reconnectSuggested(_), .peerClosed:
            break
        case .viabilityChanged(let changed):
            Logging.l(tag: "IldamDriverSDK", "[WebSocket] Viability changed: \(changed)")
        }
    }
}

extension WebSocketManager {
    private func handleIncoming(text: String) {
        guard let jsonData = text.data(using: .utf8) else { return }

        do {
            let base = try decoder.decode(SocketBase.self, from: jsonData)
            guard let channel = WebSocketOrderChannels(rawValue: base.channel) else {
                Logging.l("❓ Unknown channel: \(base.channel)")
                return
            }

            switch channel {
            case .ordersMe:
                try decodeAndDelegate(jsonData, type: DNetActiveOrderListResponse.self, for: channel)
            case .me, .info, .balanceIncome, .balanceExpense, .balance, .fotocontrol:
                try decodeAndDelegate(jsonData, type: DNetExecutorMeResponse.self, for: channel)
            case .ordersEther:
                try decodeAndDelegate(jsonData, type: DNetResEtherResponse.self, for: channel)
            case .orderSendToEther:
                try decodeAndDelegate(jsonData, type: DNetOrderSentToEtherResult.self, for: channel)
            case .orderUpdateFromEther:
                try decodeAndDelegate(jsonData, type: DNetOrderSentToEtherResult.self, for: channel)
            case .orderSendToExecutor, .orderSendToExecutorFromNonstop, .orderAppointToExecutor:
                try decodeAndDelegate(jsonData, type: DNetOrderSentToExecutorResult.self, for: channel)
            case .orderRemoveFromAppointedExecutor, .orderRemoveFromEther, .orderRemoveFromExecutor:
                try decodeAndDelegate(jsonData, type: DNetOrderRemoveFromAppointedExecutor.self, for: channel)
            case .orderUpdate:
                try decodeAndDelegate(jsonData, type: DNetOrderUpdateResult.self, for: channel)
            case .orderShow:
                try decodeAndDelegate(jsonData, type: DNetOrderShowResponse.self, for: channel)
            case .orderAppointFromOffer, .orderAppoint:
                try decodeAndDelegate(jsonData, type: DNetOrderAppointResult.self, for: channel)
            case .orderCompletedFromPanel, .orderComplete:
                try decodeAndDelegate(jsonData, type: DNetOrderCompletedFromPanel.self, for: channel)
            case .statusUpdateFromPanel, .orderStatusUpdate:
                try decodeAndDelegate(jsonData, type: DNetOrderStatusUpdateFromPanelResult.self, for: channel)
            case .orderCanceledFromClient, .orderCanceledFromPanel, .orderCancel:
                try decodeAndDelegate(jsonData, type: DNetOrderCanceledFromPanel.self, for: channel)
            case .tariffConfigs:
                try decodeAndDelegate(jsonData, type: DNetOrderTariffConfigResponse.self, for: channel)
            case .curbDefault:
                try decodeAndDelegate(jsonData, type: DNetDefaultTariffResult.self, for: channel)
            case .curbCreate:
                try decodeAndDelegate(jsonData, type: DNetCrubOrderResponse.self, for: channel)
            case .getCondition, .condition, .panelCondition:
                try decodeAndDelegate(jsonData, type: DNetGetConditionResponse.self, for: channel)
            case .orderSkip:
                Logging.l("[WebSocket] ℹ️ Ignoring channel: \(channel.rawValue)")
            }

        } catch {
            Logging.l("[WebSocket] ⚠️ Decoding error: \(error)")
        }
    }

    private func decodeAndDelegate<T: DNetResBody>(_ data: Data, type: T.Type, for channel: WebSocketOrderChannels) throws {
        let result: SocketRes = try decoder.decode(SocketRes<T>.self, from: data)
        delegate?.didReceive(channel: channel, message: result)
        
        switch channel {
        case .me:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveMe(.init(from: response))
            }
        case .info:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveInfo(.init(from: response))
            }
        case .balanceIncome:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveInfo(.init(from: response))
            }
        case .balance:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveInfo(.init(from: response))
            }
        case .balanceExpense:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveInfo(.init(from: response))
            }
        case .fotocontrol:
            if let response = result.result as? DNetExecutorMeResponse {
                channelDelegate?.onReceiveInfo(.init(from: response))
            }
        case .ordersEther:
            if let response = result.result as? DNetResEtherResponse {
                channelDelegate?.onReceiveOrdersEther(OrderListResponse(from: response))
            }
        case .orderUpdateFromEther:
            if let response = result.result as? DNetOrderSentToEtherResult {
                channelDelegate?.onReceiveOrderUpdateFromEther(.init(from: response))
            }
        case .orderSendToExecutor:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                channelDelegate?.onReceiveOrderSendToExecutor(.init(from: response))
            }
        case .orderSendToExecutorFromNonstop:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                channelDelegate?.onReceiveOrderSendToExecutor(.init(from: response))
            }
        case .orderAppointToExecutor:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                channelDelegate?.onReceiveOrderSendToExecutor(.init(from: response))
            }
        case .orderRemoveFromAppointedExecutor:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                channelDelegate?.onReceiveOrderRemoveFromAppointedExecutor(try .init(from: response))
            }
        case .orderRemoveFromEther:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                channelDelegate?.onReceiveOrderRemoveFromAppointedExecutor(try .init(from: response))
            }
        case .orderRemoveFromExecutor:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                channelDelegate?.onReceiveOrderRemoveFromAppointedExecutor(try .init(from: response))
            }
        case .orderUpdate:
            if let response = result.result as? DNetOrderUpdateResult {
                channelDelegate?.onReceiveOrderUpdate(.init(from: response))
            }
        case .orderShow:
            if let response = result.result as? DNetOrderShowResponse {
                channelDelegate?.onReceiveOrderShow(.init(from: response))
            }
        case .orderAppointFromOffer:
            if let response = result.result as? DNetOrderAppointResult {
                channelDelegate?.onReceiveOrderAppointFromOffer(try .init(from: response))
            }
        case .orderAppoint:
            if let response = result.result as? DNetOrderAppointResult {
                channelDelegate?.onReceiveOrderAppointFromOffer(try .init(from: response))
            }
        case .orderCompletedFromPanel:
            if let response = result.result as? DNetOrderCompletedFromPanel {
                channelDelegate?.onReceiveOrderCompletedFromPanel(try .init(from: response))
            }
        case .statusUpdateFromPanel:
            if let response = result.result as? DNetOrderStatusUpdateFromPanelResult {
                channelDelegate?.onReceiveStatusUpdateFromPanel(try .init(from: response))
            }
        case .orderStatusUpdate:
            if let response = result.result as? DNetOrderStatusUpdateFromPanelResult {
                channelDelegate?.onReceiveStatusUpdateFromPanel(try .init(from: response))
            }
        case .orderCanceledFromClient:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                channelDelegate?.onReceiveOrderCanceledFromClient(try .init(from: response))
            }
        case .orderCanceledFromPanel:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                channelDelegate?.onReceiveOrderCanceledFromClient(try .init(from: response))
            }
        case .orderCancel:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                channelDelegate?.onReceiveOrderCanceledFromClient(try .init(from: response))
            }
        case .tariffConfigs:
            if let response = result.result as? DNetOrderTariffConfigResponse {
                channelDelegate?.onReceiveTariffConfigs(.init(from: response))
            }
        case .curbDefault:
            if let response = result.result as? DNetDefaultTariffResult {
                channelDelegate?.onReceiveCurbDefault(.init(from: response))
            }
        case .curbCreate:
            if let response = result.result as? DNetCrubOrderResponse {
                channelDelegate?.onReceiveCurbCreate(.init(from: response))
            }
        case .getCondition:
            if let response = result.result as? DNetGetConditionResponse {
                channelDelegate?.onReceiveGetCondition(.init(from: response))
            }
        case .panelCondition:
            if let response = result.result as? DNetGetConditionResponse {
                channelDelegate?.onReceiveGetCondition(.init(from: response))
            }
        case .condition:
            if let response = result.result as? DNetGetConditionResponse {
                channelDelegate?.onReceiveGetCondition(.init(from: response))
            }
        case .orderSkip:
            break
        default:
            break
        }
    }
    
    private struct SocketBase: Decodable {
        let channel: String
    }
}
