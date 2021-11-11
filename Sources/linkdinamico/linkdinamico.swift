import Foundation
import UIKit

 struct linkdinamico {
    
    var type : typeClass = .MANAGEMENT
        
    public init(type : typeClass) {
        self.type = type
    }
     
    
    enum typeClass{
        case MANAGEMENT
        case EXPRESS_CONFERENCE
        case EXPRESS_PIP_CONFERENCE
        case GUEST
        case JOIN_CONFERENCE
        case JOIN_CONFERENCE_PIP
    }
    
    public func login(command : String,
                     // token : String,
                      showPIP : Bool,
                     // auth : String,
                      confId : String,
                      name : String,
                      email : String,
                      completion: @escaping (Result<URL,Error>) -> Void){
        
        //generate ShortDynamicLink
        let url = URL(string: "https://test-iam.videoconferenciaclaro.com/iam/v1/business/firebase/shortLink")!
        
        let showPIPS = showPIP ? "1" : "0"
        
        let json: [String : Any] = ["token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5jYWRtaW4iLCJhdXRoX3R5cGUiOiJBVVRIVE9LRU4iLCJob3N0IjoidmlkZW9jb25mZXJlbmNpYWNsYXJvLmNvbSIsInRva2VuIjoiTnlzUjYtQTNnbXEtc3lxd1ktR2FpbTMtdFdkZ2oiLCJuYW1lIjoiVW4gVGFsIEZ1bGFubyIsImNvbXBhbnkiOiJBTUNPIiwibGFuZyI6ImVzX214IiwicmVnaW9uIjoibWV4aWNvIn0.7OXFT_igd4FTL5QgMxvUQwnK1iqKFnG0zdF6wMEaP7Y", "command" : command,
                                    "showPIP" : showPIPS, confId : "3887943495", "name" : name, "email" : email]
        
        switch type {
        case .MANAGEMENT:
            <#code#>
        case .EXPRESS_CONFERENCE:
            <#code#>
        case .EXPRESS_PIP_CONFERENCE:
            <#code#>
        case .GUEST:
            <#code#>
        case .JOIN_CONFERENCE:
            <#code#>
        case .JOIN_CONFERENCE_PIP:
            <#code#>
        }
        
        
        
        
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
}
