//
//  File.swift
//  
//
//  Created by Jorge Efrain Sanchez Figueroa on 16/11/21.
//

import Foundation
import UIKit

protocol actionsControlConferenceDelegate: AnyObject {
    func microphoneAction()
    func telephoneAction()
}

open class ControlConference : UIView {

    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var hangUpButton: UIButton!
    var isHiddenButton = true
    var delegate: actionsControlConferenceDelegate?
    
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
        self.microphoneButton?.isHidden = self.isHiddenButton
        self.hangUpButton?.isHidden = self.isHiddenButton
    }
    
    @IBAction func microfoneAction(_ sender: Any) {
        print("microphoneAction")
        self.delegate?.microphoneAction()
    }
    
    @IBAction func telephoneAction(_ sender: Any) {
        print("telephoneAction")
        self.delegate?.telephoneAction()
    }
    @IBAction func tapGestureAction(_ sender: Any) {
        self.isHiddenButton = !self.isHiddenButton
        self.microphoneButton?.isHidden = self.isHiddenButton
        self.hangUpButton?.isHidden = self.isHiddenButton
        
    }
}
