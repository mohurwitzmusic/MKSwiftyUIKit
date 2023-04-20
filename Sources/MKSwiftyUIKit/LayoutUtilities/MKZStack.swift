import UIKit

open class MKZStack: UIView {
    
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
        
        public static func buildBlock(_ components: [UIView]...) -> [UIView] {
            components.flatMap { $0 }
        }
        
        public static func buildExpression(_ expression: [UIView]) -> [UIView] {
            expression
        }
    }
    
    public init(@ViewBuilder contents: (UIView) -> [UIView]) {
        super.init(frame: .zero)
        contents(self).forEach { addSubview($0) }
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
}
