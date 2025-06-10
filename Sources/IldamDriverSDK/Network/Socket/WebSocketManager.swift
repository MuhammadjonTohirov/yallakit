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
    func didPeerClosed()
    func socketReconnectSuggested()
    func didConnect()
}

public extension WebSocketDelegateHandler {
    func didReceive<T: NetResBody>(channel: WebSocketOrderChannels, message: SocketRes<T>) {}
    func didDisconnect(error: Error?) {}
    func didPeerClosed() {}
    func didConnect() {}
    func socketReconnectSuggested() {}
}

public final class WebSocketManager: WebSocketDelegate, @unchecked Sendable {
    @MainActor public static let shared = WebSocketManager()
    private var socket: WebSocket?
    private var isConnected: Bool = false
    private var token: String?
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    public weak var delegate: WebSocketDelegateHandler?
    
    private var listeners = NSHashTable<AnyObject>.weakObjects()
    private var listenerObjects: [any WebSocketChannelHandler] {
        listeners.allObjects.compactMap({$0 as? WebSocketChannelHandler})
    }
    private let listenersQueue = DispatchQueue(label: "WebSocketChannelHandler.listeners", attributes: .concurrent)

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

    public func disconnect(force: Bool = false) {
        if force {
            socket?.forceDisconnect()
        } else {
            socket?.disconnect()
        }
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
            Logging.l(tag: "[WebSocket]", "Connected success")
            delegate?.didConnect()
        case .disconnected(let reason, let code):
            isConnected = false
            Logging.l(tag: "[WebSocket]", "Disconnected: \(reason) (code: \(code))")
            delegate?.didDisconnect(error: WSError(type: .serverError, message: reason, code: code))

        case .text(let text):
            handleIncoming(text: text)
        case .binary(let data):
            Logging.l(tag: "[WebSocket]", "Received binary data of size: \(data.count)")

        case .error(let error):
            isConnected = false
            Logging.l(tag: "[WebSocket]", "Error: \(String(describing: error))")
            delegate?.didDisconnect(error: error)

        case .cancelled:
            isConnected = false
            Logging.l(tag: "[WebSocket]", "Connection cancelled")
            delegate?.didDisconnect(error: nil)

        case .pong(_), .ping(_):
            Logging.l(tag: "[WebSocket]", "Event: \(event)")
        case .peerClosed:
            self.delegate?.didPeerClosed()
        case .reconnectSuggested(_):
            self.delegate?.socketReconnectSuggested()
        case .viabilityChanged(let changed):
            Logging.l(tag: "[WebSocket]", "Viability changed: \(changed)")
        }
    }
    
    public func subscribeSocketChannelHandler(_ listener: WebSocketChannelHandler) {
        listenersQueue.async(flags: .barrier) {
            if self.listeners.contains(listener) {
                return
            }
            debugPrint("WebSocketManager", "Listener", listener.self)
            self.listeners.add(listener)
        }
    }
    
    public func removeListener(_ listener: WebSocketChannelHandler) {
        debugPrint("WebSocketManager", "Remove Listener", listener.self)
        listenersQueue.async(flags: .barrier) {
            self.listeners.remove(listener)
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
                listenerObjects.forEach({$0.onReceiveMe(.init(from: response))})
            }
        case .info:
            if let response = result.result as? DNetExecutorMeResponse {
                listenerObjects.forEach({$0.onReceiveInfo(.init(from: response))})
            }
        case .balanceIncome:
            if let response = result.result as? DNetExecutorMeResponse {
                listenerObjects.forEach({$0.onReceiveBalanceIncome(.init(from: response))})
            }
        case .balance:
            if let response = result.result as? DNetExecutorMeResponse {
                listenerObjects.forEach({$0.onReceiveBalance(.init(from: response))})
            }
        case .balanceExpense:
            if let response = result.result as? DNetExecutorMeResponse {
                listenerObjects.forEach({$0.onReceiveBalanceExpense(.init(from: response))})
            }
        case .fotocontrol:
            if let response = result.result as? DNetExecutorMeResponse {
                listenerObjects.forEach({$0.onReceiveInfo(.init(from: response))})
            }
        case .ordersEther:
            if let response = result.result as? DNetResEtherResponse,
               let orderList = OrderListResponse(from: response) {
                listenerObjects.forEach { $0.onReceiveOrdersEther(orderList) }
            }
        case .orderUpdateFromEther:
            if let response = result.result as? DNetOrderSentToEtherResult {
                listenerObjects.forEach({$0.onReceiveOrderUpdateFromEther(.init(from: response))})
            }
        case .orderSendToExecutor:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                listenerObjects.forEach({$0.onReceiveOrderSendToExecutor(.init(from: response))})
            }
        case .orderSendToExecutorFromNonstop:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                listenerObjects.forEach({$0.onReceiveOrderSendToExecutorFromNonStop(.init(from: response))})
            }
        case .orderAppointToExecutor:
            if let response = result.result as? DNetOrderSentToExecutorResult {
                listenerObjects.forEach({$0.onReceiveOrderAppointToExecutor(.init(from: response))})
            }
        case .orderRemoveFromAppointedExecutor:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                let _response: OrderRemoveFromAppointedExecutorResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderRemoveFromAppointedExecutor(_response)
                })
            }
        case .orderRemoveFromEther:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                let _response: OrderRemoveFromAppointedExecutorResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderRemoveFromEther(_response)
                })
            }
        case .orderRemoveFromExecutor:
            if let response = result.result as? DNetOrderRemoveFromAppointedExecutor {
                let _response: OrderRemoveFromAppointedExecutorResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderRemoveFromExecutor(_response)
                })
            }
        case .orderUpdate:
            if let response = result.result as? DNetOrderUpdateResult {
                let _response: OrderUpdateSocketResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderUpdate(_response)
                })
            }
        case .orderShow:
            if let response = result.result as? DNetOrderShowResponse {
                let _response: OrderShowResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderShow(_response)
                })
            }
        case .orderAppointFromOffer:
            if let response = result.result as? DNetOrderAppointResult {
                let _response: OrderAppointedResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderAppointFromOffer(_response)
                })
            }
        case .orderAppoint:
            if let response = result.result as? DNetOrderAppointResult {
                let _response: OrderAppointedResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderAppoint(_response)
                })
            }
        case .orderCompletedFromPanel:
            if let response = result.result as? DNetOrderCompletedFromPanel {
                let _response: OrderCompletedFromPanel = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderCompletedFromPanel(_response)
                })
            }
        case .statusUpdateFromPanel:
            if let response = result.result as? DNetOrderStatusUpdateFromPanelResult {
                let _response: OrderStatusUpdateFromPanelResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveStatusUpdateFromPanel(_response)
                })
            }
        case .orderStatusUpdate:
            if let response = result.result as? DNetOrderStatusUpdateFromPanelResult {
                let _response: OrderStatusUpdateFromPanelResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderStatusUpdate(_response)
                })
            }
        case .orderCanceledFromClient:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                let _response: OrderCanceledFromPanelResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderCanceledFromClient(_response)
                })
            }
        case .orderCanceledFromPanel:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                let _response: OrderCanceledFromPanelResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderCanceledFromPanel(_response)
                })
            }
        case .orderCancel:
            if let response = result.result as? DNetOrderCanceledFromPanel {
                let _response: OrderCanceledFromPanelResponse = try .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveOrderCancel(_response)
                })
            }
        case .tariffConfigs:
            if let response = result.result as? DNetOrderTariffConfigResponse {
                let _response: OrderTariffConfigurationResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveTariffConfigs(_response)
                })
            }
        case .curbDefault:
            if let response = result.result as? DNetDefaultTariffResult {
                let _response: DriverDefaultTariffResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveCurbDefault(_response)
                })
            }
        case .curbCreate:
            if let response = result.result as? DNetCrubOrderResponse {
                let _response: DriverCrubResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveCurbCreate(_response)
                })
            }
        case .getCondition:
            if let response = result.result as? DNetGetConditionResponse {
                let _response: DriverGetConditionResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveGetCondition(_response)
                })
            }
        case .panelCondition:
            if let response = result.result as? DNetGetConditionResponse {
                let _response: DriverGetConditionResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceivePanelCondition(_response)
                })
            }
        case .condition:
            if let response = result.result as? DNetGetConditionResponse {
                let _response: DriverGetConditionResponse = .init(from: response)
                listenerObjects.forEach({
                    $0.onReceiveCondition(_response)
                })
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
