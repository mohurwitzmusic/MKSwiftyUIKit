import UIKit


open class MKFluentStackView: UIStackView {
    
    @resultBuilder
    public struct ViewBuilder {
        public static func buildBlock(_ components: UIView...) -> [UIView] {
            return components
        }
        public static func buildExpression(_ expression: UIView) -> UIView {
            return expression
        }
        
        public static func buildExpression(_ expression: MKFluentStackView) -> UIView {
            return expression
        }
        
        public static func buildExpression<Content: UIView>(_ expression: () -> Content) -> UIView {
            return expression()
        }
    }
    
    public init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 2, @ViewBuilder content: () -> [UIView]) {
        super.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
        let views = content()
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


open class MKHStack: MKFluentStackView {
    
    public init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewBuilder content: () -> [UIView]) {
        super.init(axis: .horizontal, distribution: distribution, alignment: alignment, spacing: spacing, content: content)
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


open class MKVStack: MKFluentStackView {
    
    public init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0, @ViewBuilder content: () -> [UIView]) {
        super.init(axis: .vertical, distribution: distribution, alignment: alignment, spacing: spacing, content: content)
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


public extension MKFluentStackView {
    
    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        self.spacing = value
        
        func updateSpacing(for view: UIView) {
            if let stackView = view as? MKFluentStackView {
                stackView.spacing = value
            }
            view.subviews.forEach { subview in
                updateSpacing(for: subview)
            }
        }
        
        arrangedSubviews.forEach { subview in
            updateSpacing(for: subview)
        }
        
        return self
    }
    
}


