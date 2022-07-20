//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UILabel {
    
    convenience init(text: String? = nil, alignment: NSTextAlignment = .natural, textColor: UIColor = .label, font: UIFont = .systemFont(ofSize: UIFont.systemFontSize)) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = alignment
        self.textColor = textColor
        self.font = font
    }
    
    func setTextAndHideIfNil(_ text: String?) {
        self.text = text
        self.isHidden = text == nil
    }
}
