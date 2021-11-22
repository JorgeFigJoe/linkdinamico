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
        //URLRequest(url: URL(string: urlWSM)!)
        //let delegate = ClientSocketDelegate()
        socket.delegate = self
        print(socket)
        socket.connect()
    }
}

extension WebSocketManager : WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        print(event)
    }
    
}
