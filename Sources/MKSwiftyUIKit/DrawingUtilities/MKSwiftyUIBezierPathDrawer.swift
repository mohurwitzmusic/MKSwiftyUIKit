//
//  File.swift
//  
//
//  Created by MOH on 2022-09-01.
//

import UIKit

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
        path.move(to: .init(point: point))
        return self
    }
    
    @discardableResult public func addLine(to point: Point) -> Self {
        path.addLine(to: .init(point: point))
        return self
    }
    
    @discardableResult public func setLineWidth(_ width: CGFloat) -> Self {
        path.lineWidth = width
        return self
    }
    
    @discardableResult public func close() -> Self {
        path.close()
        return self
    }
    
    @discardableResult public func addArc(center: Point, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> Self {
        path.addArc(withCenter: .init(point: center), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return self
    }
    
    @discardableResult public func addQuadCurve(to point: MKSwiftyUIBezierPathDrawer.Point, controlPoint: MKSwiftyUIBezierPathDrawer.Point) -> Self {
        path.addQuadCurve(to: .init(point: point), controlPoint: .init(point: controlPoint))
        return self
    }

    @discardableResult public func beginNewPath() -> Self {
        self.path = path
        return self
    }
    
    
}

fileprivate extension CGPoint {
    
    init(point: MKSwiftyUIBezierPathDrawer.Point) {
        self.init(x: point.x, y: point.y)
    }
    
}


