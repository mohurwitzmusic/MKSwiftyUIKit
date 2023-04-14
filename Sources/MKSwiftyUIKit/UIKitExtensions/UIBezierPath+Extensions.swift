import UIKit


public extension UIBezierPath {
    
    static func circle(inscribingRect rect: CGRect) -> UIBezierPath {
        return UIBezierPath(arcCenter: rect.center, radius: rect.size.largestInscribedCircleRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    }
    
    static func circle(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    }
    
    @discardableResult
    func fill(color: UIColor) -> Self {
        color.setFill()
        fill()
        return self
    }
    
    @discardableResult
    func stroke(color: UIColor) -> Self {
        color.setStroke()
        stroke()
        return self
    }
    
}
