//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit

public enum MKLayoutAnchorEquality {
    case equalToConstant(CGFloat)
    case lessThanOrEqualToConstant(CGFloat)
    case greaterThanOrEqualToConstant(CGFloat)
    case equalTo(NSLayoutDimension)
    case lessThanOrEqualTo(NSLayoutDimension)
    case greaterThanOrEqualTo(NSLayoutDimension)
}
