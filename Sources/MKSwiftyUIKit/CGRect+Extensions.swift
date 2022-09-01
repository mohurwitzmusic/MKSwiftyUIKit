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

}
