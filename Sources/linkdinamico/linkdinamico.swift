import Foundation
import UIKit

 public class linkdinamico {
     
     let webSocket = WebSocketManager()
     fileprivate var jsonn : [String : Any]?
        
    public init() {
    
    }
     
     public enum  typeClass{
        case MANAGEMENT
        case EXPRESS_CONFERENCE
        case EXPRESS_PIP_CONFERENCE
        case GUEST
        case JOIN_CONFERENCE
        case JOIN_CONFERENCE_PIP
    }
     
     private func joinConference() {
         webSocket.deletage = self
         webSocket.sendjoinToRoom()
     }
     
     private func dynamicLinkGenerate(json: [String : Any],
                                      completion: @escaping (Result<URL,Error>) -> Void){
         //generate ShortDynamicLink
         let url = URL(string: "https://test-iam.videoconferenciaclaro.com/iam/v1/business/firebase/shortLink")!
         
         let headers = ["Content-Type": "application/json", "Authorization" : "Basic YW1jbzpjbGFybw=="]
         let session = URLSession.shared
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
     
         request.allHTTPHeaderFields = headers
         let jsonData = try? JSONSerialization.data(withJSONObject: json)
         request.httpBody = jsonData
         
         session.dataTask(with: request) { (data, response, error) in
             if (error != nil) {
                 print(error!)
                 completion(.failure(error!))
                    } else {
                        //let httpResponse = response as? HTTPURLResponse
                        //print(httpResponse!)

                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]{
                                guard let data = json["data"] as? NSDictionary else {return}
                                guard let shortLink = data["shortLink"] as? String else {return}
                                let urlLink = URL(string: shortLink)!
                                DispatchQueue.main.async {
                                    UIApplication.shared.open (urlLink)
                                }
                                completion(.success(urlLink))
                            }
                        } catch {
                            completion(.failure(error))
                        }

                    }
         }.resume()
     }
    
     public func login(type : typeClass,
                       //command : String,
                       token : String,
                       //showPIP : Bool,
                       confId : String,
                       name : String,
                       email : String){
         
         
         //let showPIPS = showPIP ? "1" : "0"
         
         var json: [String : Any] = ["token" : token]
         
         switch type {
         case .MANAGEMENT:
             self.dynamicLinkGenerate(json: json) { (Response) in
                //
             }
             break
         case .EXPRESS_CONFERENCE:
             json["command"] = "StartConference"
             self.jsonn = json
             self.joinConference()
         case .EXPRESS_PIP_CONFERENCE:
             json["command"] = "StartConference"
             json["showPIP"] = true
             self.jsonn = json
             self.joinConference()
         case .GUEST:
             json["confId"] = confId
             json["showPIP"] = false
             json["name"] = name
             json["email"] = email
             self.dynamicLinkGenerate(json: json) { (Response) in
                //
             }
             
         case .JOIN_CONFERENCE:
             json["command"] = "StartConference"
             json["confId"] = confId
             json["showPIP"] = false
             json["name"] = name
             json["email"] = email
             self.jsonn = json
             self.joinConference()
             
         case .JOIN_CONFERENCE_PIP:
             json["command"] = "StartConference"
             json["confId"] = confId
             json["showPIP"] = true
             json["name"] = name
             json["email"] = email
             self.jsonn = json
             self.joinConference()
         }
     }
     
     public func openModule(view : UIView) -> UIView{
         let controls = ControlConference(frame: CGRect(x: 8 , y: 100, width: view.frame.width/2, height: view.frame.width/2) )
         view.addSubview(controls)
         return controls
     }

}

extension linkdinamico : resultWebSocketDelegate {
    func joinConferenceResult(room: String) {
        guard var myjson = self.jsonn else {return}
        myjson["idRoom"] = room
        print("Me llego la URL")
        self.dynamicLinkGenerate(json: myjson) { (Response)  in
        }
    }
    
    
}
