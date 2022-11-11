//
//  File.swift
//  
//
//  Created by MOH on 2022-09-01.
//

import UIKit

@available(*, deprecated, message: "Use MKSwiftyPathDrawer Instead")
public class MKSwiftyUIBezierPathDrawer {
    
    public static func beginWithPath() -> MKSwiftyUIBezierPathDrawer {
        return .init()
    }

    public typealias Point = (x: CGFloat, y: CGFloat)
    
    private init() { }
    
    public private(set) var path = UIBezierPath()
    
    @discardableResult public func setStrokeColor(_ color: UIColor) -> Self {
        color.setStroke()
        return self
    }
    
    @discardableResult public func setFillColor(_ color: UIColor) -> Self {
        color.setFill()
        return self
    }
    
    @discardableResult public func stroke() -> Self {
        path.stroke()
        return self
    }
    
    @discardableResult public func fill() -> Self {
        path.fill()
        return self
    }

    @discardableResult public func move(to point: Point) -> Self {
        path.move(to: pointToCGPoint(point))
        return self
    }
    
    @discardableResult public func addLine(to point: Point) -> Self {
        path.addLine(to: pointToCGPoint(point))
        return self
    }
    
    @discardableResult public func setLineWidth(_ width: CGFloat) -> Self {
        path.lineWidth = width
        return self
    }
    
    @discardableResult public func setLineJoinStyle(_ style: CGLineJoin) -> Self {
        path.lineJoinStyle = style
        return self
    }
    
    @discardableResult public func setLineCapStyle(_ style: CGLineCap) -> Self {
        path.lineCapStyle = style
        return self
    }
    
    @discardableResult public func setMiterLimit(_ limit: CGFloat) -> Self {
        path.miterLimit = limit
        return self
    }
    
    @discardableResult public func close() -> Self {
        path.close()
        return self
    }
    
    @discardableResult public func addArc(center: Point, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> Self {
        let cgPoint = pointToCGPoint(center)
        path.addArc(withCenter: cgPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }
    
    @discardableResult public func addArcAtCurrentPoint(radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> Self {
        path.addArc(withCenter: path.currentPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }
    
    @discardableResult public func addQuadCurve(to point: MKSwiftyUIBezierPathDrawer.Point, controlPoint: MKSwiftyUIBezierPathDrawer.Point) -> Self {
        let cgPoint = pointToCGPoint(controlPoint)
        let cgControlPoint = pointToCGPoint(controlPoint)
        path.addQuadCurve(to: cgPoint, controlPoint: cgControlPoint)
        return self
    }

    @discardableResult public func beginNewPath() -> Self {
        self.path = UIBezierPath()
        return self
    }
    
    private func pointToCGPoint(_ point: Point) -> CGPoint {
        return .init(x: point.x, y: point.y)
    }
}
