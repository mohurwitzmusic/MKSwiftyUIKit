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
    
    /// Sets the text field's `leftView` to a `UIImageView`.
    
    @discardableResult
    func setLeftViewImage(_ image: UIImage?, tintColor: UIColor? = nil, width: CGFloat = 32, insets: UIEdgeInsets = .zero) -> Self {
        guard var image = image else {
            self.leftView = nil
            self.leftViewMode = .never
            return self
        }
        if let tintColor {
            image = image.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        }
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        leftView = containerView
        containerView.constrainWidth(.equalToConstant(width))
        let imageView = UIImageView(contentMode: .scaleAspectFit)
        imageView.image = image
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.constrainToBounds(of: containerView, insets: insets)
        if let tintColor {
            leftView?.tintColor = tintColor
        }
        leftViewMode = .always
        return self
    }
    
    /// Fluent API for setting the text field's `leftView` to a `UIImage`.
    
    @discardableResult
    func setLeftViewImage(systemName: String, width: CGFloat = 32) -> Self {
        self.setLeftViewImage(.init(systemName: systemName), width: width)
        return self
    }
    
    /// Fluent API for setting the text field's `text`.
    
    @discardableResult
    func setText(_ string: String?) -> Self {
        self.text = text
        return self
    }
    
    /// Fluent API for setting the text field's `placeholder`.
    
    @discardableResult
    func setPlaceholder(_ string: String?) -> Self {
        self.placeholder = string
        return self
    }
    
    /// Fluent API for setting the text field's `textColor`.
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    /// Fluent API for setting the text field's `keyboardType`.
    
    @discardableResult
    func setKeyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
    
    /// Fluent API for setting the text field's `textAlignment`.
    
    @discardableResult
    func setTextAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    
    /// Fluent API for setting the text field's `borderStyle`.
    
    @discardableResult
    func setBorderStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
    
    /// Fluent API for setting the text field's `delegate`.
    
    @discardableResult
    func setDelegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// Fluent API for setting the text field's `returnKeyType`.
    
    @discardableResult
    func setReturnKeyType(_ type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }
}

