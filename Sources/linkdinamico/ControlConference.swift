//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 16/11/21.
//

import Foundation
import UIKit

class ControlConference : UIView {
    
    @IBOutlet weak var controlButton: UIButton!
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    @IBAction func controlButtonAction(_ sender: Any) {
        print("Accion de control de boton")
    }
}
