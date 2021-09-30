import FirebaseDynamicLinks
import Foundation

public struct linkdinamico {
        
    public init() {
        
    }
    
    public func generateDynamicLinks(completion: @escaping (Result<URL,Error>) -> Void){
        
        //Generate longDynamicLink
        guard let link = URL(string: "https://www.videoconferenciaclaro.com") else { return }
        let dynamicLinksDomainURIPrefix = "https://testvcc.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder!.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.DynamicLinksvcclaro2")
        linkBuilder!.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.receivedynamiclink")
        
        //Parametros
        linkBuilder!.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder!.socialMetaTagParameters?.title = "Ejemplo de parametro"
        linkBuilder!.socialMetaTagParameters?.descriptionText = "Enlace de descripcion"
        
        guard let longDynamicLink = linkBuilder!.url else { return }
        //completion(.success(longDynamicLink))
        
        
        //generate ShortDynamicLink
        let url = URL(string: "https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyA2FuB7RvppYnJ7HEs-hxa3pV9EI-nV7MI")!
        
        let json: [String : Any] = ["longDynamicLink" : "\(longDynamicLink)"]
        
        let headers = ["Content-Type": "application/json"]
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        request.allHTTPHeaderFields = headers
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        session.dataTask(with: request) { (data, response, error) in
            if (error != nil) {
                print(error!)
                completion(.success(longDynamicLink))
                   } else {
                       //let httpResponse = response as? HTTPURLResponse
                       //print(httpResponse!)

                       do {
                           if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]{
                               guard let shortDynamicLink = json["shortLink"] as? String else {return}
                               let shortDynamicLinkURL = URL(string: shortDynamicLink)!
                               completion(.success(shortDynamicLinkURL))
                           }
                       } catch {
                           completion(.success(longDynamicLink))
                       }

                   }
        }.resume()
    }
}
