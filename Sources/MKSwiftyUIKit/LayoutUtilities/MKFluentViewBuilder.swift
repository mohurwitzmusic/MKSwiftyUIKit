import UIKit

@resultBuilder
public struct MKFluentViewBuilder {
    public static func buildBlock(_ components: UIView...) -> [UIView] {
        return components
    }
    public static func buildExpression(_ expression: UIView) -> UIView {
        return expression
    }
    
    public static func buildExpression(_ expression: UIStackView) -> UIView {
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
