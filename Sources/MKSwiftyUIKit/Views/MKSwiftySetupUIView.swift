//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


open class MKSwiftySetupUIView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open func setup() { }
    
    
}
