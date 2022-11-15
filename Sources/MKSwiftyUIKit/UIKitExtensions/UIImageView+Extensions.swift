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
    
    convenience init(imageSystemName: String, symbolScale: UIImage.SymbolScale = .default, tint: UIColor? = nil) {
        self.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        self.image = .init(systemName: imageSystemName)
        self.preferredSymbolConfiguration = .init(scale: symbolScale)
        if let tint {
            self.tintColor = tint
        }
    }
    
    @discardableResult
    func setImageAndHideIfNil(_ image: UIImage?) -> Self {
        self.image = image
        self.isHidden = image == nil
        return self
    }
    
    @discardableResult
    func setImage(systemName: String) -> Self {
        self.image = .init(systemName: systemName)
        return self
    }
    
    @discardableResult
    func setSymbolScale(_ scale: UIImage.SymbolScale) -> Self {
        self.preferredSymbolConfiguration = .init(scale: scale)
        return self
    }
    
    @discardableResult
    func setContentMode(_ mode: ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
}
