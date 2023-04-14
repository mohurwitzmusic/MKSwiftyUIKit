import UIKit

public extension UIRectCorner {
    
    /// The top-left and bottom-left corners of the rectangle.
    static let leftCorners: UIRectCorner = [.topLeft, .bottomLeft]
    
    /// The top-left and top-right corners of the rectangle.
    static let topCorners: UIRectCorner = [.topLeft, .topRight]
    
    /// The top-right and bottom-right corners of the rectangle.
    static let rightCorners: UIRectCorner = [.topRight, .bottomRight]
    
    /// The bottom-left and bottom-right corners of the rectangle.
    static let bottomCorners: UIRectCorner = [.bottomLeft, .bottomRight]
    
}
