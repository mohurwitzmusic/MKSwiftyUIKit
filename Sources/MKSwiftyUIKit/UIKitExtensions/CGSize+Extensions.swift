import UIKit

public extension CGSize {
    
    var area: CGFloat {
        width * height
    }
    
    var perimeter: CGFloat {
        return 2 * (width + height)
    }
    
    var largestInscribedCircleRadius: CGFloat {
        return min(width, height) / 2
    }
    
    /// Creates a `CGSize` with equal width and height
    
    init(square: CGFloat) {
        self.init(width: square, height: square)
    }
    
}
