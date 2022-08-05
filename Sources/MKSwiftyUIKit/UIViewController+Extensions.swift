//
//  File.swift
//  
//
//  Created by MOH on 2022-08-04.
//

import UIKit

public extension UIViewController {

    func quickAddChildAndView(_ viewController: UIViewController, frame: CGRect?) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        view.addSubview(viewController.view)
        if let frame = frame {
            viewController.view.frame = frame
        } else {
            viewController.view.frame = self.view.bounds
        }
        viewController.didMove(toParent: self)
    }

}
