import UIKit

public extension UIEdgeInsets {
    
    @available(*, deprecated, renamed: "init(dxy:)")
    static func allEdges(_ inset: CGFloat) -> UIEdgeInsets {
        .init(dxy: inset)
    }
    
    init(dx: CGFloat, dy: CGFloat) {
        self = .init(top: dy, left: dx, bottom: dy, right: dx)
    }
   
    init(dxy: CGFloat) {
        self = .init(dx: dxy, dy: dxy)
    }
}
