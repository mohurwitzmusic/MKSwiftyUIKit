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
    
    /// Fluent API for adding the view as an arranged subview of a `UIStackView`.
    
    @discardableResult
    func addAsArrangedSubiew(of stackView: UIStackView) -> Self {
        stackView.addArrangedSubview(self)
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

//MARK: - Constraint Extensions

public extension UIView {
    
    /// Fluent API for constraining a view's edges to a layout guide. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToEdges(_ edges: UIRectEdge, ofLayoutGuide layoutGuide: UILayoutGuide, priority: UILayoutPriority = .defaultHigh, NSLayoutConstraint insets: UIEdgeInsets = .zero, activate: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top))
        }
        if edges.contains(.left) {
            constraints.append(leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right))
        }
        if edges.contains(.bottom) {
            constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom))
        }
        for constraint in constraints {
            constraint.isActive = activate
            constraint.priority = priority
        }
        return self
    }
    
    /// Fluent API for constraining a view's edges to the edges of a superview. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToEdges(_ edges: UIRectEdge, of view: UIView, priority: UILayoutPriority = .defaultHigh, insets: UIEdgeInsets = .zero, activate: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top))
        }
        if edges.contains(.left) {
            constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right))
        }
        if edges.contains(.bottom) {
            constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom))
        }
        for constraint in constraints {
            constraint.isActive = activate
            constraint.priority = priority
        }
        return self
    }
    
    
    /// Fluent API for constraining all of a view's edges to a layout guide. Returns the created constraints and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToLayoutGuide(_ layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .defaultHigh, activate: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left))
        constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top))
        constraints.append(trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.right))
        constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom))
        for constraint in constraints {
            constraint.isActive = activate
            constraint.priority = priority
        }
        return self
    }
    
    /// Fluent API for constraining all of a view's edges to the edges of a superview. Returns the created constraints and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false
    
    @discardableResult
    func constrainToBounds(of view: UIView, insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .defaultHigh, activate: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left))
        constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top))
        constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right))
        constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom))
        for constraint in constraints {
            constraint.isActive = activate
            constraint.priority = priority
        }
        return self
    }

    /// Concise method for setting a view's `widthAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainWidth(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    /// Concise method for setting a view's `heightAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainHeight(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    /// Concise method for setting a view's `centerXAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainCenterX(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    
    /// Concise method for setting a view's `centerYAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainCenterY(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    

    /// Concise method for setting a view's `leadingAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainLeadingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    /// Concise method for setting a view's `topAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainTopAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    /// Concise method for setting a view's `trailingAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainTrailingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }

    /// Concise method for setting a view's `bottomAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainBottomAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    
    
}
