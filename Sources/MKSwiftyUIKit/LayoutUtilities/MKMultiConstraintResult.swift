import UIKit

public struct MKKMultiConstraintResult {
    var top: NSLayoutConstraint?
    var left: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    public init() {}
    public func activate(_ isActivated: Bool = true, edges: [UIRectEdge] = [.top, .left, .bottom, .right]) {
        if edges.contains(.top) { top?.isActive = isActivated }
        if edges.contains(.left) { left?.isActive = isActivated }
        if edges.contains(.right) { right?.isActive = isActivated }
        if edges.contains(.bottom) { bottom?.isActive = isActivated }
    }
}
