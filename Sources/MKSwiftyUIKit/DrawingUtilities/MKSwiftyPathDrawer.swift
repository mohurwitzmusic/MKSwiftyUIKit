import UIKit

public class MKSwiftyPathDrawer {
    
    public static func beginWithPath() -> MKSwiftyPathDrawer {
        return .init()
    }
    
    private init() { }
    
    public private(set) var path = UIBezierPath()
    public private(set) var savedPoint: CGPoint?
    
    @discardableResult
    public func beginNewPath() -> Self {
        self.path = UIBezierPath()
        return self
    }
    
    @discardableResult
    public func setStrokeColor(_ color: UIColor) -> Self {
        color.setStroke()
        return self
    }
    
    @discardableResult
    public func setFillColor(_ color: UIColor) -> Self {
        color.setFill()
        return self
    }
    
    @discardableResult
    public func stroke() -> Self {
        path.stroke()
        return self
    }
    
    @discardableResult
    public func fill() -> Self {
        path.fill()
        return self
    }
    
    @discardableResult
    public func close() -> Self {
        path.close()
        return self
    }
    
    @discardableResult
    public func setLineWidth(_ width: CGFloat) -> Self {
        path.lineWidth = width
        return self
    }
    
    @discardableResult
    public func setLineJoinStyle(_ style: CGLineJoin) -> Self {
        path.lineJoinStyle = style
        return self
    }
    
    @discardableResult
    public func setLineCapStyle(_ style: CGLineCap) -> Self {
        path.lineCapStyle = style
        return self
    }
    
    @discardableResult
    public func setMiterLimit(_ limit: CGFloat) -> Self {
        path.miterLimit = limit
        return self
    }
    
    @discardableResult
    public func moveTo(point: CGPoint) -> Self {
        path.move(to: point)
        return self
    }
    
    @discardableResult
    public func moveToSavedPoint() -> Self {
        if let savedPoint {
            path.move(to: savedPoint)
        } else {
            print("Move failed: no point was saved")
        }
        return self
    }

    @discardableResult
    public func moveTo(x: CGFloat, y: CGFloat) -> Self {
        return self.moveTo(point: .init(x: x, y: y))
    }

    @discardableResult
    public func addLineTo(point: CGPoint) -> Self {
        path.addLine(to: point)
        return self
    }
    
    @discardableResult
    public func addLineTo(x: CGFloat, y: CGFloat) -> Self {
        return self.addLineTo(point: .init(x: x, y: y))
    }
    
    @discardableResult
    public func addLineToSavedPoint() -> Self {
        if let savedPoint {
            path.addLine(to: savedPoint)
        } else {
            print("Add line failed: no point was saved")
        }
        return self
    }
    
    
    @discardableResult
    public func addArcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * CGFloat.pi, clockwise: Bool = true) -> Self {
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }
    
    @discardableResult
    public func addArcWithCenterAt(x: CGFloat, y: CGFloat, radius: CGFloat, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * CGFloat.pi, clockwise: Bool = true) -> Self {
        return self.addArcAt(center: .init(x: x, y: y), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }

    @discardableResult
    public func addArcAtCurrentPoint(radius: CGFloat, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * CGFloat.pi, clockwise: Bool = true) -> Self {
        return self.addArcAt(center: path.currentPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    @discardableResult
    public func addArcAtSavedPoint(radius: CGFloat, startAngle: CGFloat = 0, endAngle: CGFloat = 2 * CGFloat.pi, clockwise: Bool = true) -> Self {
        if let savedPoint {
            path.addArc(withCenter: savedPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        } else {
            print("Add arc failed: no point was saved")
        }
        return self
    }

    
    @discardableResult public func addQuadCurveTo(point: CGPoint, controlPoint: CGPoint) -> Self {
        path.addQuadCurve(to: point, controlPoint: point)
        return self
    }
    
    @discardableResult
    public func saveCurrentPoint() -> Self {
        self.savedPoint = path.currentPoint
        return self
    }

    
}
