//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIImageView {
    
    convenience init(contentMode: ContentMode, image: UIImage? = nil, preferredSymbolConfiguration: UIImage.SymbolConfiguration = .init(scale: .default)) {
        self.init(frame: .zero)
        self.contentMode = contentMode
        self.image = image
        self.preferredSymbolConfiguration = preferredSymbolConfiguration
    }
    
    
    func setImageAndHideIfNil(_ image: UIImage?) {
        self.image = image
        self.isHidden = image == nil
    }
    
}
