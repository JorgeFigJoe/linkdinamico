import FirebaseDynamicLinks
import Foundation

public struct linkdinamico {
        
    public init() {
        
    }
    
    public func generateDynamicLinks(completion: @escaping (Result<URL,Error>) -> Void){
        
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
        print("The long URL is: \(longDynamicLink)")
        //completion(.success(longDynamicLink))
        
        
            linkBuilder!.shorten() { url, warnings, error in
              //guard let url = url else { return  }
                
                if let url2 = url {
                    print("The short URL is: \(url2)")
                      completion(.success(url2))
                }else{
                    print("The long URL is: \(longDynamicLink)")
                      completion(.success(longDynamicLink))
                }
            }
        
        
    }
}
