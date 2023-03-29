//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIStackView {
    
    /// Convenience initializer for specifying all the `UIStackView`s configuration parameters directly in the initializer,
    
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    /// Fluent API for adding multiple views as arranged subviews.
    
    @discardableResult
    func addArrangedSubviews(_ subviews: [UIView]) -> Self {
        subviews.forEach { addArrangedSubview($0) }
        return self
    }
    
    /// Fluent API for adding multiple views as arranged subviews using Swift's variadic paramters,
    
    @discardableResult
    func addArrangedSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { addArrangedSubview($0) }
        return self
    }
    
    /// Fluent API for specifying all the `UIStackView`s configuration paramters.
    
    @discardableResult
    func configure(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0) -> Self {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        return self
    }
}
