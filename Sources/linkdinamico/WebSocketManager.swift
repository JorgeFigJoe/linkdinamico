//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 22/11/21.
//

import Foundation
import Starscream


protocol resultWebSocketDelegate : AnyObject {
    func joinConferenceResult(room: String)
}

class WebSocketManager {
        
    let socket: WebSocket
    var delegate: resultWebSocketDelegate?
    var identifier = ""

    init() {
        let urlString = "wss://58peqhog65.execute-api.us-east-1.amazonaws.com/development"

        socket = WebSocket(request: URLRequest(url: URL(string: urlString)!))
        socket.delegate = self
        print(socket)
        socket.connect()
    }
    
    func sendjoinToRoom(){
        let json = """
                    {
                      "action": "joinToRoom",
                      "payload":{
                        "id": null,
                        "connectionType": "ios-integration-client"
                      }
                    }
                    """
        socket.write(string: json)
    }
    
    func changeStatusMicrophone(){
        let json = """
                    {
                     "action":"command",
                     "payload":{
                          "command": TOGGLE_AUDIO,
                          "room": "\(self.identifier)",
                          "extraData": {},
                          "connectionType": "ios-integration-client"
                      }
                    }
                    """
        socket.write(string: json)
    }
    
    func hangUpActionn(){
        let json = """
                    {
                      "action":"command",
                      "payload":{
                          "command": HANGUP,
                          "room": "\(self.identifier)",
                          "extraData": null,
                          "connectionType": "ios-integration-client"
                        }
                    }
                    """
        socket.write(string: json)
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
            
            let data = string.data(using: .utf8)!
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                    guard let data = json["payload"] as? NSDictionary else {return}
                    guard let room = data["room"] as? String else {return}
                    print(room)
                    self.identifier = room
                    self.delegate?.joinConferenceResult(room: room)
                }
            } catch {
                print("bad json")
            }
            
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
            print("websocket is not connected: \(String(describing: error))")
            }
    }
    
}
