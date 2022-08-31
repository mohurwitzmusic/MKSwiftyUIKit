//
//  MKSwiftySetupUIControl.swift
//  
//
//  Created by MOH on 2022-08-31.
//

import UIKit

open class MKSwiftySetupUIControl: UIControl {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    
    open func setup() {
        
    }
    
}
