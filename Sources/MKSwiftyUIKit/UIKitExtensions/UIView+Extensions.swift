//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIView {
    
    func constrainToEdges(_ edges: UIRectEdge, ofLayoutGuide layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.right) {
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left).isActive = true
        }
    }
    
    func constrainToEdges(_ edges: UIRectEdge, of view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.right) {
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
        }
    }
    
    @discardableResult
    func constrainToLayoutGuide(_ layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
        ])
        return self
    }
    
    @discardableResult
    func constrainToBounds(of view: UIView, insets: UIEdgeInsets = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
        return self
    }
    
    @discardableResult
    func constrainWidth(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalToConstant(let cGFloat):
            constraint = self.widthAnchor.constraint(equalToConstant: cGFloat)
        case .lessThanOrEqualToConstant(let cGFloat):
            constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: cGFloat)
        case .greaterThanOrEqualToConstant(let cGFloat):
            constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: cGFloat)
        case .equalTo(let nSLayoutDimension):
            constraint = self.widthAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        case .lessThanOrEqualTo(let nSLayoutDimension):
            constraint = self.widthAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqualTo(let nSLayoutDimension):
            constraint = self.widthAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        }
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func constrainHeight(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalToConstant(let cGFloat):
            constraint = self.heightAnchor.constraint(equalToConstant: cGFloat)
        case .lessThanOrEqualToConstant(let cGFloat):
            constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: cGFloat)
        case .greaterThanOrEqualToConstant(let cGFloat):
            constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: cGFloat)
        case .equalTo(let nSLayoutDimension):
            constraint = self.heightAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        case .lessThanOrEqualTo(let nSLayoutDimension):
            constraint = self.heightAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqualTo(let nSLayoutDimension):
            constraint = self.heightAnchor.constraint(equalTo: nSLayoutDimension, multiplier: multiplier, constant: constant)
        }
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    

    @discardableResult
    func constrainCenterX(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = centerXAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = centerXAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = centerXAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = centerXAnchor.constraint(equalToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = centerXAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = centerXAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func constrainCenterY(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = centerYAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = centerYAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = centerYAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = centerYAnchor.constraint(equalToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = centerYAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = centerYAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    
    @discardableResult
    func constrainLeadingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = leadingAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = leadingAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = leadingAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = leadingAnchor.constraint(equalToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func constrainTopAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = topAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = topAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = topAnchor.constraint(equalToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func constrainTrailingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = trailingAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = trailingAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = trailingAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = trailingAnchor.constraint(equalToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = trailingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func constrainBottomAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch equality {
        case .equalTo:
            constraint = bottomAnchor.constraint(equalTo: anchor)
        case .lessThanOrEqualTo:
            constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor)
        case .greaterThanOrEqualTo:
            constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor)
        case .equalToSystemToSystemSpacing:
            constraint = bottomAnchor.constraint(equalToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .lessThanOrEqualToSystemSpacing:
            constraint = bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        case .greaterThanOrEqualToSystemSpacing:
            constraint = bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: anchor, multiplier: multiplier)
        }
        constraint.constant = constant
        constraint.isActive = isActive
        constraint.priority = priority
        return constraint
    }
    
    @discardableResult
    func setVerticalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) -> Self {
        self.setContentCompressionResistancePriority(compression, for: .vertical)
        self.setContentHuggingPriority(hugging, for: .vertical)
        return self
    }
    
    @discardableResult
    func setHorizontalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) -> Self {
        self.setContentCompressionResistancePriority(compression, for: .horizontal)
        self.setContentHuggingPriority(hugging, for: .horizontal)
        return self
    }
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init(backgroundColor: backgroundColor)
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    convenience init(cornerRadius: CGFloat) {
        self.init()
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    @discardableResult
    func addSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { addSubview($0) }
        return self
    }
    
    @discardableResult
    func addSubviews(_ subviews: [UIView]) -> Self {
        subviews.forEach { addSubviews($0) }
        return self
    }
    
    @discardableResult
    func addSubviewConstrainingToLayoutGuide(_ subview: UIView, insets: UIEdgeInsets = .zero) -> Self {
        self.addSubview(subview)
        subview.constrainToLayoutGuide(layoutMarginsGuide, insets: insets)
        return self
    }
    
    @discardableResult
    func addSubviewConstrainingToBounds(_ subview: UIView, insets: UIEdgeInsets = .zero) -> Self {
        self.addSubview(subview)
        subview.constrainToBounds(of: self, insets: insets)
        return self
    }
    
    @discardableResult
    func setBackgroundColor( _ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setCornerRadis(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> Self {
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
    
    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func setTag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    @discardableResult
    func setFrame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    @discardableResult
    func setIsUserInterctionEnabled(_ enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func addAsSubview(of superview: UIView) -> Self {
        superview.addSubview(self)
        return self
    }
    
    @discardableResult
    func setLayoutMargins(_ margins: NSDirectionalEdgeInsets) -> Self {
        self.directionalLayoutMargins = margins
        return self
    }
    
    @discardableResult
    func setLeadingMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.leading = margin
        return self
    }
    
    @discardableResult
    func setTopMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.top = margin
        return self
    }
    
    @discardableResult
    func setTrailingMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.trailing = margin
        return self
    }
    
    @discardableResult
    func setBottomMargin(_ margin: CGFloat) -> Self {
        self.directionalLayoutMargins.bottom = margin
        return self
    }
}
