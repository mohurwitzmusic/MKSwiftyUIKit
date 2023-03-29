//
//  File.swift
//  
//
//  Created by MOH on 2022-08-04.
//

import UIKit

public extension UIViewController {
    
    /// Convenience method for adding a child `UIViewController`, calling the appropriate lifecycle events
    ///
    /// - calls `willMove(toParent:)`
    /// - calls `addChild(_:)`
    /// - adds the `viewController`'s `view` as a subview with the provided `frame`
    /// - calls `diMove(toParent:)`
    
    
    func addViewControllerAsChild(_ viewController: UIViewController, frame: CGRect) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = frame
        viewController.didMove(toParent: self)
    }

    
}
