import UIKit

public extension CGSize {
    
    var area: CGFloat {
        width * height
    }
    
    var perimeter: CGFloat {
        return 2 * (width + height)
    }
    
}
