//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit

public extension UIColor {
    
    func withBrightnessComponent(_ brightness: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        guard self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            print("** some problem demuxing the color")
            return .gray
        }
        
        let nudged = b * brightness
        
        return UIColor(hue: h, saturation: s, brightness: nudged, alpha: a)
    }

}
