import UIKit

public extension UIEdgeInsets {
    
    init(allEdges inset: CGFloat) {
        self = .init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(dx: CGFloat, dy: CGFloat) {
        self = .init(top: dy, left: dx, bottom: dy, right: dx)
    }
   
}
