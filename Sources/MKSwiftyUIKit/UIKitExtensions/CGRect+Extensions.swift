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
    
    static func aligned(toCorner corner: UIRectCorner, of bounds: CGRect, size: CGSize, constrainToBounds: Bool = false) -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var newSize = size
        
        if constrainToBounds {
            let maxWidth = bounds.width
            let maxHeight = bounds.height
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
            //
        } else if corner.contains(.topRight) {
            x = bounds.width - newSize.width
        } else if corner.contains(.bottomLeft) {
            y = bounds.height - newSize.height
        } else if corner.contains(.bottomRight) {
            x = bounds.width - newSize.width
            y = bounds.height - newSize.height
        }
        return .init(x: x, y: y, width: newSize.width, height: newSize.height)
    }
    
    @available(*, deprecated, renamed: "aligned(toCorner:of:size:)")
    static func pinned(toCorner corner: UIRectCorner, in bounds: CGRect, size: CGSize, constrainToBounds: Bool = false) -> CGRect {
        aligned(toCorner: corner, of: bounds, size: size, constrainToBounds: constrainToBounds)
    }
 
    static func aligned(toEdge edge: UIRectEdge, of bounds: CGRect, size: CGSize, constrainToBounds: Bool = false) -> CGRect {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var newSize = size
        
        if constrainToBounds {
            let maxWidth = bounds.width
            let maxHeight = bounds.height
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
        case .bottom:
            x = (bounds.width - newSize.width) / 2
            y = bounds.height - newSize.height
        case .left:
            y = (bounds.height - newSize.height) / 2
        case .right:
            x = bounds.width - newSize.width
            y = (bounds.height - newSize.height) / 2
        default:
            break
        }
        
        return .init(x: x, y: y, width: newSize.width, height: newSize.height)
    }
    
    @available(*, deprecated, renamed: "aligned(toEdge:of:size:)")
    static func pinned(toEdge edge: UIRectEdge, in bounds: CGRect, size: CGSize, constrainToBounds: Bool = false) -> CGRect {
        aligned(toEdge: edge, of: bounds, size: size, constrainToBounds: constrainToBounds)
    }
    
    static func centered(in rect: CGRect, size: CGSize, constrainToBounds: Bool = false) -> CGRect {
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
    
    func translatedBy(dx: CGFloat, dy: CGFloat) -> CGRect {
        var copy = self
        copy.origin.x += dx
        copy.origin.y += dy
        return copy
    }
    
    func constrained(to rect: CGRect, maintainAspectRatio: Bool = true) -> CGRect {
        var result = self
        if result.origin.x < rect.origin.x {
            result.origin.x = rect.origin.x
        }
        if result.origin.y < rect.origin.y {
            result.origin.y = rect.origin.y
        }
        if result.maxX > rect.maxX {
            result.origin.x -= result.maxX - rect.maxX
        }
        if result.maxY > rect.maxY {
            result.origin.y -= result.maxY - rect.maxY
        }
        if maintainAspectRatio {
            if result.maxX > rect.maxX {
                let scaleFactor = rect.width / result.width
                result.size.width *= scaleFactor
                result.size.height *= scaleFactor
            }
            if result.maxY > rect.maxY {
                let scaleFactor = rect.height / result.height
                result.size.width *= scaleFactor
                result.size.height *= scaleFactor
            }
        } else {
            if result.maxX > rect.maxX {
                result.size.width = rect.width
            }
            if result.maxY > rect.maxY {
                result.size.height = rect.height
            }
        }
        
        return result
    }
    
}
