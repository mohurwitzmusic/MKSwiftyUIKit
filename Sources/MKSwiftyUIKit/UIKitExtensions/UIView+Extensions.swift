//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIView {
    
    /// Fluent API for setting both the view's `contentCompressionResistancePriority` and `contentHuggingPriority`
    /// along the vertial axis.
    
    @discardableResult
    func setVerticalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) -> Self {
        self.setContentCompressionResistancePriority(compression, for: .vertical)
        self.setContentHuggingPriority(hugging, for: .vertical)
        return self
    }
    
    /// Fluent API for setting both the view's `contentCompressionResistancePriority` and `contentHuggingPriority`
    /// along the horizonal axis.
    
    @discardableResult
    func setHorizontalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) -> Self {
        self.setContentCompressionResistancePriority(compression, for: .horizontal)
        self.setContentHuggingPriority(hugging, for: .horizontal)
        return self
    }
    
    /// Fluent API for adding multiple subviews using Swift's variadic parameters.
    
    @discardableResult
    func addSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    /// Fluent API for adding multiple subviews.
    
    @discardableResult
    func addSubviews(_ subviews: [UIView]) -> Self {
        subviews.forEach { addSubviews($0) }
        return self
    }
    
    /// Fluent API for setting the view's background color.
        
    @discardableResult
    func setBackgroundColor( _ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    /// Fluent API for setting the view's corner radius.
    
    @discardableResult
    func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> Self {
        self.layer.cornerRadius = radius
        if corners.contains(.topLeft) {
            layer.maskedCorners.insert(.layerMinXMinYCorner)
        }
        if corners.contains(.topRight) {
            layer.maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if corners.contains(.bottomLeft) {
            layer.maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if corners.contains(.bottomRight) {
            layer.maskedCorners.insert(.layerMaxXMaxYCorner)
        }
        return self
    }
    
    /// Fluent API for setting the view's  tint color.
    
    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    /// Fluent API for setting the view's tag.
    
    @discardableResult
    func setTag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    /// Fluent API for setting both the view's minimum and maximum `UIContentSizeCategory` to the same value.
    
    @discardableResult
    func setContentSizeCategory(_ category: UIContentSizeCategory) -> Self {
        self.minimumContentSizeCategory = category
        self.maximumContentSizeCategory = category
        return self
    }
    
    /// Fluent API for setting the view's minimum and maximum `UIContentSizeCategory`.
    
    @discardableResult
    func setContentSizeCategory(minimum: UIContentSizeCategory, maximum: UIContentSizeCategory) -> Self {
        self.minimumContentSizeCategory = minimum
        self.maximumContentSizeCategory = minimum
        return self
    }
    
    /// Fluent API for setting the view's frame.
    
    @discardableResult
    func setFrame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    /// Fluent API for setting the view's `isUserInteractionEnabled` state.
    
    @discardableResult
    func setIsUserInterctionEnabled(_ enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    
    /// Fluent API for adding the view as a subview of a superview.
    
    @discardableResult
    func addAsSubview(of superview: UIView) -> Self {
        superview.addSubview(self)
        return self
    }
    
    /// Fluent API for setting the view's layout margins.
    
    @discardableResult
    func setLayoutMargins(_ margins: NSDirectionalEdgeInsets) -> Self {
        self.directionalLayoutMargins = margins
        return self
    }
    
    
    /// Fluent API for setting the view's leading margin.
    
    @discardableResult
    func setLeadingMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.leading = margin
        return self
    }
    
    /// Fluent API for setting the view's top margin.
    
    @discardableResult
    func setTopMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.top = margin
        return self
    }
    
    /// Fluent API for setting the view's trailing margin.
    
    @discardableResult
    func setTrailingMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.trailing = margin
        return self
    }
    
    /// Fluent API for setting the view's bottom margin.
    
    @discardableResult
    func setBottomMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.bottom = margin
        return self
    }
    
    /// Fluent API for setting the view's `clipsToBounds`.
    
    @discardableResult
    func setClipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    
    @discardableResult
    func setIsHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
}

