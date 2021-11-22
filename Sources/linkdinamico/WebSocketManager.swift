//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 22/11/21.
//

import Foundation
import Starscream

class WebSocketManager {
        
    let socket: WebSocket

    init() {
        let urlString = "wss://58peqhog65.execute-api.us-east-1.amazonaws.com/development?connectionType=ios-integration-client"

        socket = WebSocket(request: URLRequest(url: URL(string: urlString)!))
        socket.delegate = self
        print(socket)
        socket.connect()
    }
}

extension WebSocketManager : WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
        switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                print("websocket is cancelled")
            case .error(let error):
                print("websocket is not connected: \(error)")
            }
    }
    
}
