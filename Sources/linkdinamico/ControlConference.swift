//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 16/11/21.
//

import Foundation
import UIKit

open class ControlConference : UIView {

        
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
    
    @IBAction func microfoneAction(_ sender: Any) {
        print("Accion de microfono")
    }
    
    @IBAction func telephoneAction(_ sender: Any) {
        print("Accion de telefono")
    }
}
