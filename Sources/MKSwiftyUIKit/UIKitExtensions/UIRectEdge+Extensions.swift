import UIKit

public extension UIRectCorner {
    
    /// The top-left and bottom-left corners of the rectangle.
    static let leftEdge: UIRectCorner = [.topLeft, .bottomLeft]
    
    /// The top-left and top-right corners of the rectangle.
    static let topEdge: UIRectCorner = [.topLeft, .topRight]
    
    /// The top-right and bottom-right corners of the rectangle.
    static let rightEdge: UIRectCorner = [.topRight, .bottomRight]
    
    /// The bottom-left and bottom-right corners of the rectangle.
    static let bottomEdge: UIRectCorner = [.bottomLeft, .bottomRight]
    
}
