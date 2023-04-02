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
    
    static func pinned(toCorner corner: UIRectCorner, in bounds: CGRect, size: CGSize, insets: (x: CGFloat, y: CGFloat) = (0, 0), constrainToBounds: Bool = false) -> CGRect {
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var newSize = size
        
        if constrainToBounds {
            let maxWidth = bounds.width - insets.x
            let maxHeight = bounds.height - insets.y
            let aspectRatio = size.width / size.height
            if maxWidth < size.width || maxHeight < size.height {
                let width = min(maxWidth, size.width)
                let height = min(maxHeight, size.height)
                if width / height > aspectRatio {
                    newSize = CGSize(width: height * aspectRatio, height: height)
                } else {
                    newSize = CGSize(width: width, height: width / aspectRatio)
                }
            }
        }
        
        if corner.contains(.topLeft) {
            x = insets.x
            y = insets.y
        } else if corner.contains(.topRight) {
            x = bounds.width - newSize.width - insets.x
            y = insets.y
        } else if corner.contains(.bottomLeft) {
            x = insets.x
            y = bounds.height - newSize.height - insets.y
        } else if corner.contains(.bottomRight) {
            x = bounds.width - newSize.width - insets.x
            y = bounds.height - newSize.height - insets.y
        }
        return .init(x: x, y: y, width: newSize.width, height: newSize.height)
    }
 
    static func pinned(toEdge edge: UIRectEdge, in bounds: CGRect, size: CGSize, insets: (x: CGFloat, y: CGFloat) = (0, 0), constrainToBounds: Bool = false) -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var newSize = size
        
        if constrainToBounds {
            let maxWidth = bounds.width - insets.x
            let maxHeight = bounds.height - insets.y
            let aspectRatio = size.width / size.height
            
            if maxWidth < size.width || maxHeight < size.height {
                let width = min(maxWidth, size.width)
                let height = min(maxHeight, size.height)
                
                if width / height > aspectRatio {
                    newSize = CGSize(width: height * aspectRatio, height: height)
                } else {
                    newSize = CGSize(width: width, height: width / aspectRatio)
                }
            }
        }
        
        switch edge {
        case .top:
            x = (bounds.width - newSize.width) / 2
            y = insets.y
        case .bottom:
            x = (bounds.width - newSize.width) / 2
            y = bounds.height - newSize.height - insets.y
        case .left:
            x = insets.x
            y = (bounds.height - newSize.height) / 2
        case .right:
            x = bounds.width - newSize.width - insets.x
            y = (bounds.height - newSize.height) / 2
        default:
            break
        }
        
        return .init(x: x, y: y, width: newSize.width, height: newSize.height)
    }
    
    static func centered(in rect: CGRect, size: CGSize, constrainToBounds: Bool) -> CGRect {
        var newSize = size
        
        if constrainToBounds {
            let maxWidth = rect.width
            let maxHeight = rect.height
            let aspectRatio = size.width / size.height
            
            if maxWidth < size.width || maxHeight < size.height {
                let width = min(maxWidth, size.width)
                let height = min(maxHeight, size.height)
                
                if width / height > aspectRatio {
                    newSize = CGSize(width: height * aspectRatio, height: height)
                } else {
                    newSize = CGSize(width: width, height: width / aspectRatio)
                }
            }
        }
        
        return .init(x: rect.midX - (newSize.width/2), y: rect.midY - (newSize.height/2), width: newSize.width, height: newSize.height)
    }
    
    func resized(to size: CGSize, cornerAnchor: UIRectCorner) -> CGRect {
        var newRect = self
        
        switch cornerAnchor {
        case .topLeft:
            newRect.size = size
        case .topRight:
            newRect.origin.x += self.size.width - size.width
            newRect.size = size
        case .bottomLeft:
            newRect.origin.y += self.size.height - size.height
            newRect.size = size
        case .bottomRight:
            newRect.origin.x += self.size.width - size.width
            newRect.origin.y += self.size.height - size.height
            newRect.size = size
        default:
            break
        }
        
        return newRect
    }
    
    func resized(to size: CGSize, edgeAnchor: UIRectEdge) -> CGRect {
        var newRect = self
        switch edgeAnchor {
        case .top:
            let horizontalInset = (width - size.width) / 2
            newRect.origin.y += height - size.height
            newRect.size.width = size.width
            newRect.origin.x += horizontalInset
        case .left:
            let verticalInset = (height - size.height) / 2
            newRect.size.height = size.height
            newRect.origin.y += verticalInset
        case .bottom:
            let horizontalInset = (width - size.width) / 2
            newRect.size.width = size.width
            newRect.origin.x += horizontalInset
        case .right:
            let verticalInset = (height - size.height) / 2
            newRect.origin.x += width - size.width
            newRect.size.height = size.height
            newRect.origin.y += verticalInset
        default:
            break
        }
        return newRect
    }
    
}
