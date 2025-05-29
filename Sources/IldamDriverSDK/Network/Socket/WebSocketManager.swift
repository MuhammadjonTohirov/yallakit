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

public final class WebSocketManager: WebSocketDelegate {
    @MainActor public static let shared = WebSocketManager()
    private var socket: WebSocket?
    private var isConnected: Bool = false
    private var token: String?
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    public weak var delegate: WebSocketDelegateHandler?

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
            print("[WebSocket] Disconnected: \(reason) (code: \(code))")
            delegate?.didDisconnect(error: WSError(type: .serverError, message: reason, code: code))

        case .text(let text):
            handleIncoming(text: text)
        case .binary(let data):
            print("[WebSocket] Received binary data of size: \(data.count)")

        case .error(let error):
            isConnected = false
            print("[WebSocket] Error: \(String(describing: error))")
            delegate?.didDisconnect(error: error)

        case .cancelled:
            isConnected = false
            print("[WebSocket] Connection cancelled")
            delegate?.didDisconnect(error: nil)

        case .pong(_), .ping(_), .viabilityChanged(_), .reconnectSuggested(_), .peerClosed:
            break
        }
    }
}

extension WebSocketManager {
    private func handleIncoming(text: String) {
        guard let jsonData = text.data(using: .utf8) else { return }

        do {
            let base = try decoder.decode(SocketBase.self, from: jsonData)
            guard let channel = WebSocketOrderChannels(rawValue: base.channel) else {
                print("❓ Unknown channel: \(base.channel)")
                return
            }

            switch channel {
            case .ordersMe:
                try decodeAndDelegate(jsonData, type: DNetActiveOrderListResponse.self, for: channel)
            case .me, .info, .balanceIncome, .balanceExpense, .balance, .fotocontrol:
                try decodeAndDelegate(jsonData, type: DNetExecutorMeResponse.self, for: channel)
            case .ordersEther:
                try decodeAndDelegate(jsonData, type: DNetResEtherResponse.self, for: channel)
            case .orderSendToEther, .orderUpdateFromEther:
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
                print("ℹ️ Ignoring channel: \(channel.rawValue)")
            }

        } catch {
            print("⚠️ Decoding error: \(error)")
        }
    }

    private func decodeAndDelegate<T: DNetResBody>(_ data: Data, type: T.Type, for channel: WebSocketOrderChannels) throws {
        let res = try decoder.decode(SocketRes<T>.self, from: data)
        delegate?.didReceive(channel: channel, message: res)
    }
    
    private struct SocketBase: Decodable {
        let channel: String
    }
}
