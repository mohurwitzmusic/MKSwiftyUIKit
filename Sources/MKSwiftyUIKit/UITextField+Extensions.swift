//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UITextField {
    
    convenience init(text: String? = nil, placeholder: String? = nil, alignment: NSTextAlignment = .natural, borderStyle: BorderStyle = BorderStyle.none) {
        self.init(frame: .zero)
        self.text = text
        self.placeholder = placeholder
        self.borderStyle = borderStyle
        self.textAlignment = alignment
    }
    
}
