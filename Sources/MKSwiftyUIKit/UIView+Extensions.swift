//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UIView {
    
    func constrainToLayoutGuide(_ layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    func constrainToBounds(of view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
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
    
    func setVerticalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) {
        self.setContentCompressionResistancePriority(compression, for: .vertical)
        self.setContentHuggingPriority(hugging, for: .vertical)
    }
    
    func setHorizontalLayoutPriority(compression: UILayoutPriority, hugging: UILayoutPriority) {
        self.setContentCompressionResistancePriority(compression, for: .horizontal)
        self.setContentHuggingPriority(hugging, for: .horizontal)
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
}
