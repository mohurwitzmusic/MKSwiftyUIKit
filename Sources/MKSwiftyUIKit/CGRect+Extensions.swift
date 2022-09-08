//
//  File.swift
//  
//
//  Created by MOH on 2022-09-01.
//

import UIKit

public extension CGRect {
    
    var center: CGPoint {
        return .init(x: midX, y: midY)
    }
    
    var largestInscribedCircleRadius: CGFloat {
        return min(width, height) / 2
    }
    
    var topLeft: CGPoint {
        .init(x: minX, y: minY)
    }
    
    var topRight: CGPoint {
        .init(x: maxX, y: minY)
    }
    
    var bottomLeft: CGPoint {
        .init(x: minX, y: maxY)
    }
    
    var bottomRight: CGPoint {
        .init(x: maxX, y: maxY)
    }

    static func centered(in rect: CGRect, size: CGSize) -> CGRect {
        return .init(x: rect.midX - (size.width/2), y: rect.midY - (size.height/2), width: size.width, height: size.height)
    }
    
}
