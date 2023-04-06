import UIKit


public extension UIBezierPath {
    
    static func circle(inscribingRect rect: CGRect) -> UIBezierPath {
        return UIBezierPath(arcCenter: rect.center, radius: rect.size.largestInscribedCircleRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    }
    
}
