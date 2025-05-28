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
    func didReceive<T: NetResBody>(_ response: SocketRes<T>, for channel: String)
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
            guard let data = text.data(using: .utf8) else { return }
            do {
                let baseResponse = try decoder.decode(SocketRes<EmptyNetResBody>.self, from: data)
                delegate?.didReceive(baseResponse, for: baseResponse.channel)
            } catch {
                print("[WebSocket] JSON decoding failed: \(error)")
            }

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

public struct EmptyNetResBody: NetResBody, Codable {}
