import Foundation
import UIKit

public struct linkdinamico {
        
    public init() {
        
    }
    
    public func login(completion: @escaping (Result<URL,Error>) -> Void){
        
        //generate ShortDynamicLink
        let url = URL(string: "https://test-iam.videoconferenciaclaro.com/iam/v1/business/firebase/shortLink")!
        
        let json: [String : Any] = ["token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im5jYWRtaW4iLCJhdXRoX3R5cGUiOiJORVhUQ0xPVUQiLCJob3N0IjoiYjU0Mi0yODA2LTEwNWUtMTgtNGM1MC02ZDAwLTY2MzEtY2Q0YS1kNmY2Lm5ncm9rLmlvIiwidG9rZW4iOiJOeXNSNi1BM2dtcS1zeXF3WS1HYWltMy10V2RnaiJ9.PMtoaYq0DKKvcePg9Om5UvZv9t4BCfbATgZ9j9OFqm4", "showUI" : true]
        
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
                               UIApplication.shared.open (urlLink)
                               completion(.success(urlLink))
                           }
                       } catch {
                           completion(.failure(error))
                       }

                   }
        }.resume()
    }
}
