import UIKit

public protocol MKFluentConstrainable: UIView { }

extension UIView: MKFluentConstrainable { }

public extension MKFluentConstrainable {
    
    /// Fluent API for constraining a view's edges to a layout guide. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToEdges(_ edges: UIRectEdge, ofLayoutGuide layoutGuide: UILayoutGuide, priority: UILayoutPriority = .defaultHigh, NSLayoutConstraint insets: UIEdgeInsets = .zero, activate: Bool = true) -> (constraints: MKKMultiConstraintResult, view: Self) {
        translatesAutoresizingMaskIntoConstraints = false
        var result = MKKMultiConstraintResult()
        if edges.contains(.top) {
            result.top = topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)
            result.top?.priority = priority
        }
        if edges.contains(.right) {
            result.right = rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right)
            result.right?.priority = priority
        }
        if edges.contains(.bottom) {
            result.bottom = bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
            result.bottom?.priority = priority
        }
        if edges.contains(.left) {
            result.left = leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left)
            result.left?.priority = priority
        }
        if activate {
            result.activate()
        }
        return (result, self)
    }
    
    /// Fluent API for constraining a view's edges to the edges of a superview. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToEdges(_ edges: UIRectEdge, of view: UIView, priority: UILayoutPriority = .defaultHigh, insets: UIEdgeInsets = .zero, activate: Bool = true) -> (constraints: MKKMultiConstraintResult, view: Self) {
        translatesAutoresizingMaskIntoConstraints = false
        var result = MKKMultiConstraintResult()
        if edges.contains(.top) {
            result.top = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
            result.top?.priority = priority
        }
        if edges.contains(.right) {
            result.right = rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)
            result.right?.priority = priority
        }
        if edges.contains(.bottom) {
            result.bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
            result.bottom?.priority = priority
        }
        if edges.contains(.left) {
            result.left = leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
            result.left?.priority = priority
        }
        if activate {
            result.activate()
        }
        return (result, self)
    }
    
    
    /// Fluent API for constraining all of a view's edges to a layout guide. Returns the created constraints and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainToLayoutGuide(_ layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero, activate: Bool = true) -> (constraints: MKKMultiConstraintResult, view: Self) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = MKKMultiConstraintResult()
        constraints.left = leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left)
        constraints.top = topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)
        constraints.right = trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.right)
        constraints.bottom = bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
        if activate {
            constraints.activate()
        }
        return (constraints, self)
    }
    
    /// Fluent API for constraining all of a view's edges to the edges of a superview. Returns the created constraints and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false
    
    @discardableResult
    func constrainToBounds(of view: UIView, insets: UIEdgeInsets = .zero, activate: Bool = true) -> (constraints: MKKMultiConstraintResult, view: Self) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = MKKMultiConstraintResult()
        constraints.left = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
        constraints.top = topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
        constraints.right = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right)
        constraints.bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        if activate {
            constraints.activate()
        }
        return (constraints, self)
    }

    /// Concise method for setting a view's `widthAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainWidth(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    /// Concise method for setting a view's `heightAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainHeight(_ equality: MKLayoutAnchorEquality, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    /// Concise method for setting a view's `centerXAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainCenterX(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    
    /// Concise method for setting a view's `centerYAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainCenterY(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    

    /// Concise method for setting a view's `leadingAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainLeadingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    /// Concise method for setting a view's `topAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainTopAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    /// Concise method for setting a view's `trailingAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.
    
    @discardableResult
    func constrainTrailingAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }

    /// Concise method for setting a view's `bottomAnchor`. Returns the created constraint and the constrained view.
    ///
    /// Automatically sets `translatesAutoResizingMasksIntoConstraints` to `false`.

    @discardableResult
    func constrainBottomAnchor(_ equality: MKEdgeAnchorLayoutEquality, anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority = .defaultHigh, multiplier: CGFloat = 1.0, constant: CGFloat = 0, isActive: Bool = true) -> (constraint: NSLayoutConstraint, view: Self) {
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
        return (constraint, self)
    }
    
    
}
