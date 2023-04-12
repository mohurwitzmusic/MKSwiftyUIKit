//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit

public extension UIFont {
    
    func emphasized() -> UIFont {
        if let fontDescriptor = self.fontDescriptor
            .withSymbolicTraits(.traitBold) {
            return UIFont(descriptor: fontDescriptor, size: 0)
        }
        return self
    }
    
    func italic() -> UIFont {
        if let fontDescriptor = self.fontDescriptor
            .withSymbolicTraits(.traitItalic) {
            return UIFont(descriptor: fontDescriptor, size: 0)
        }
        return self
    }
    
    func width(of text: String) -> CGFloat {
         let attributedString = NSAttributedString(string: text, attributes: [.font: self])
         return attributedString.size().width
     }

}

