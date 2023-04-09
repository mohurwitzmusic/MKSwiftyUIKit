import UIKit

public extension UIEdgeInsets {
    
    static func allEdges(_ inset: CGFloat) -> UIEdgeInsets {
        return .init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(dx: CGFloat, dy: CGFloat) {
        self = .init(top: dy, left: dx, bottom: dy, right: dx)
    }
   
}
