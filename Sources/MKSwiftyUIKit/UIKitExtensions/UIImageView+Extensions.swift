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
    
    
    @available(*, deprecated, message: "Use setImage(_:hidingIfNil) instead")
    @discardableResult
    func setImageAndHideIfNil(_ image: UIImage?) -> Self {
        self.setImage(image, hidingIfNil: true)
    }
    
    /// Fluent API for setting the `image` to a system image.
    
    @discardableResult
    func setImage(systemName: String) -> Self {
        self.image = .init(systemName: systemName)
        return self
    }
    
    /// Fluent API for setting the `image`, optionally hiding the view if `image` is `nil`.
    
    @discardableResult
    func setImage(_ image: UIImage?, hidingIfNil: Bool = false) -> Self {
        self.image = image
        if hidingIfNil {
            isHidden = image == nil
        }
        return self
    }
    
    /// Fluent API for setting the image's `preferredSymbolConfiguration`.
    
    @discardableResult
    func setPreferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration) -> Self {
        self.preferredSymbolConfiguration = configuration
        return self
    }
    
    /// Fluent API for setting the image's `contentMode`.
    
    @discardableResult
    func setContentMode(_ mode: ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
    
    /// Fluent API for setting the image's `adjustsImageSizeForAccessibilityContentSizeCategory`.
    
    @discardableResult
    func setAdjustsImageSizeForAccessibilityContentSizeCategory(_ enabled: Bool) -> Self {
        self.adjustsImageSizeForAccessibilityContentSizeCategory = enabled
        return self
    }
}
