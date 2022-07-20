//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension NSDirectionalEdgeInsets {
    
    var uiEdgeInsets: UIEdgeInsets {
        return .init(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
}
