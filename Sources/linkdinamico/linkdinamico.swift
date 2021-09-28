import FirebaseDynamicLinks

public struct linkdinamico {
    
    public init() {
        
    }
    
    public func generateDynamicLinks() -> URL{
        var urlDefault = URL(string: "https://www.videoconferenciaclaro.com/")!
        
        guard let link = URL(string: "https://www.videoconferenciaclaro.com") else { return urlDefault}
        let dynamicLinksDomainURIPrefix = "https://generatedynamiclink.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder!.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.DynamicLinksvcclaro2")
        linkBuilder!.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.receivedynamiclink")
        
        //Parametros
        linkBuilder!.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder!.socialMetaTagParameters?.title = "Ejemplo de parametro"
        linkBuilder!.socialMetaTagParameters?.descriptionText = "Enlace de descripcion"
        
        guard let longDynamicLink = linkBuilder!.url else { return urlDefault}
        print("The long URL is: \(longDynamicLink)")
        
        linkBuilder!.shorten() { url, warnings, error in
          guard let url = url, error == nil else { return }
          print("The short URL is: \(url)")
          urlDefault = url
        }
        return urlDefault
    }
}
