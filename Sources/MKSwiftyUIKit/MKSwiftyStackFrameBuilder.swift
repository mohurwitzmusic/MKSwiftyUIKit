//
//  MKSwiftyStackFrameBuilder.swift
//  
//
//  Created by MOH on 2022-08-29.
//

import UIKit

public protocol MKSwiftyStackFrameBuildable: AnyObject {
    func build(rect: CGRect)
}

extension CALayer: MKSwiftyStackFrameBuildable {
    public func build(rect: CGRect) {
        self.frame = rect
    }
}

extension UIView: MKSwiftyStackFrameBuildable {
    public func build(rect: CGRect) {
        self.frame = rect
    }
}



open class MKSwiftyStackFrameBuilder: MKSwiftyStackFrameBuildable {
    
    public enum Size {
        case automatic
        case absolute(CGFloat)
        case fractional(CGFloat, min: CGFloat? = nil, max: CGFloat? = nil)
    }
    
    public enum Component {
        case buildable(MKSwiftyStackFrameBuildable, Size)
        case space(Size)
    }
    
    public enum Axis {
        case horizontal
        case vertical
    }
    
    public private(set) var components = [Component]()
    public private(set) var spacing: CGFloat = 0
    public private(set) var axis = Axis.horizontal
    
    public init(axis: Axis, spacing: CGFloat) {
        self.axis = axis
        self.spacing = spacing
    }

    @discardableResult open func addComponent(_ buildable: MKSwiftyStackFrameBuildable, size: Size) -> Self {
        self.components.append(.buildable(buildable, size))
        return self
    }
    
    @discardableResult open func addBuilder(size: Size, _ buildable: (() -> MKSwiftyStackFrameBuilder)) -> Self {
        self.components.append(.buildable(buildable(), size))
        return self
    }
    
    @discardableResult open func addSpacer(size: Size) -> Self {
        self.components.append(.space(size))
        return self
    }
    
    open func build(rect: CGRect) {
        switch axis {
        case .horizontal: buildHorizontal(rect: rect)
        case .vertical: buildVertical(rect: rect)
        }
    }
    
    private func buildVertical(rect: CGRect) {
        let calculationResult = calculate(originalLength: rect.height)
        var ty = rect.minY
        for component in components {
            switch component {
            case .space(let size):
                switch size {
                case .absolute(let length):
                    ty += length
                case .fractional(let fraction, let absMin, let absMax):
                    let desired = fraction * calculationResult.availableFractionalLength
                    ty += min(max(desired, absMin ?? desired), absMax ?? desired)
                case .automatic:
                    ty += calculationResult.automaticComponentLength
                    
                }
            case .buildable(let item, let size):
                switch size {
                case .fractional(let fraction, let absMin, let absMax):
                    let desired = fraction * calculationResult.availableFractionalLength
                    let componentHeight =  min(max(desired, absMin ?? desired), absMax ?? desired)
                    item.build(rect: CGRect(x: rect.minX, y: ty, width: rect.width, height: componentHeight))
                    ty += componentHeight
                case .absolute(let length):
                    item.build(rect: CGRect(x: rect.minX, y: ty, width: rect.width, height: length))
                    ty += length
                case .automatic:
                    item.build(rect: CGRect(x: rect.minX, y: ty, width: rect.width, height: calculationResult.automaticComponentLength))
                    ty += calculationResult.automaticComponentLength
                }
            }
            ty += spacing
        }
    }
    
    private func buildHorizontal(rect: CGRect) {
        let calculationResult = calculate(originalLength: rect.width)

        var tx = rect.minX
        for component in components {
            switch component {
            case .space(let size):
                switch size {
                case .absolute(let length):
                    tx += length
                case .fractional(let fraction, let absMin, let absMax):
                    let desired = fraction * calculationResult.availableFractionalLength
                    tx += min(max(desired, absMin ?? desired), absMax ?? desired)
                case .automatic:
                    tx += calculationResult.automaticComponentLength
                    
                }
            case .buildable(let item, let size):
                switch size {
                case .fractional(let fraction, let absMin, let absMax):
                    let desired = fraction * calculationResult.availableFractionalLength
                    let componentWidth = min(max(desired, absMin ?? desired), absMax ?? desired)
                    item.build(rect:  CGRect(x: tx, y: rect.minY, width: componentWidth, height: rect.height))
                    tx += componentWidth
                case .absolute(let length):
                    item.build(rect: CGRect(x: tx, y: rect.minY, width: length, height: rect.height))
                    tx += length
                case .automatic:
                    item.build(rect: CGRect(x: tx, y: rect.minY, width: calculationResult.automaticComponentLength, height: rect.height))
                    tx += calculationResult.automaticComponentLength
                    
                }
            }
            tx += spacing
        }
    }
    
 
    
    private struct CalculationResult {
        let availableFractionalLength: CGFloat
        let automaticComponentLength: CGFloat
        let numAutomaticComponents: Int
    }
    
    private func calculate(originalLength: CGFloat) -> CalculationResult {
        var totalAvailaleFractionalWidth = originalLength
        totalAvailaleFractionalWidth -= (CGFloat(components.count - 1) * spacing)
        var numberOfAutomaticComponents: Int = 0
        for component in components {
            switch component {
            case .buildable(_, let size):
                switch size {
                case .absolute(let length):
                    totalAvailaleFractionalWidth -= length
                case .automatic:
                    numberOfAutomaticComponents += 1
                default:
                    continue
                }
            case .space(let size):
                switch size {
                case .absolute(let length):
                    totalAvailaleFractionalWidth -= length
                case .automatic:
                    numberOfAutomaticComponents += 1
                default:
                    continue
                }
            }
        }
        
        var automaticComponentLength = CGFloat(0)
        if numberOfAutomaticComponents > 0 {
            var fractionalWidthUsed = CGFloat(0)
            for component in components {
                switch component {
                case .buildable(_, let size):
                    switch size {
                    case .fractional(let fraction, let absMin, let absMax):
                        let desired = fraction * totalAvailaleFractionalWidth
                        fractionalWidthUsed += min(max(desired, absMin ?? desired), absMax ?? desired)
                    default:
                        continue
                    }
                case .space(let size):
                    switch size {
                    case .fractional(let fraction, let absMin, let absMax):
                        let desired = fraction * totalAvailaleFractionalWidth
                        fractionalWidthUsed += min(max(desired, absMin ?? desired), absMax ?? desired)
                    default:
                        continue
                    }
                }
            }
            let remainder = totalAvailaleFractionalWidth - fractionalWidthUsed
            automaticComponentLength = remainder / CGFloat(numberOfAutomaticComponents)
        }
        

        return CalculationResult.init(availableFractionalLength: totalAvailaleFractionalWidth,
                                      automaticComponentLength: automaticComponentLength,
                                      numAutomaticComponents: numberOfAutomaticComponents)
    }

}




