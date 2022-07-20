//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIImageView {
    
    convenience init(contentMode: ContentMode, image: UIImage? = nil) {
        self.init(frame: .zero)
        self.contentMode = contentMode
        self.image = image
    }
    
    
    func setImageAndHideIfNil(_ image: UIImage?) {
        self.image = image
        self.isHidden = image == nil
    }
    
}
