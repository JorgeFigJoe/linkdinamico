//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 16/11/21.
//

import Foundation
import UIKit

open class ControlConference : UIView {
    
    @IBOutlet weak var participantImage: UIImageView!
    @IBOutlet weak var microphoneButtonn: UIButton!
    @IBOutlet weak var hangUpButton: UIButton!
    
    
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.commonInitialization()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    @objc func commonInitialization(){
        let view = Bundle.module.loadNibNamed("ContrlConference", owner: self, options: nil)?.first as! UIView
      view.frame = self.bounds
      self.addSubview(view)
    }
    
    @IBAction func microphoneAction(_ sender: Any) {
        print("Accion de microfono")
    }
    
    @IBAction func hangUpActionn(_ sender: Any) {
        print("Accion de colgar llamada")
    }
}
