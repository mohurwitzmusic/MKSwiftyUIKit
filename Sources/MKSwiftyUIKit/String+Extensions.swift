//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import Foundation

public extension String {
    
    static let loremIpsum: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    static func loremIpsum(length: Int) -> String {
        let index = loremIpsum.index(loremIpsum.startIndex, offsetBy: length)
        return String(loremIpsum[..<index])
    }
    
}
