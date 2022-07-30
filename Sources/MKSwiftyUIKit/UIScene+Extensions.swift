//
//  File.swift
//  
//
//  Created by MOH on 2022-07-30.
//

import UIKit


extension UIScene {
    
    func configureWindow(rootViewController: UIViewController, embedInNavigationController: Bool, toolbarHidden: Bool) -> UIWindow! {
        if let windowScene = self as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let initialViewController: UIViewController
            if embedInNavigationController {
                let navigationController = UINavigationController()
                navigationController.setToolbarHidden(toolbarHidden, animated: false)
                navigationController.viewControllers = [rootViewController]
                initialViewController = navigationController
            } else {
                initialViewController = rootViewController
            }
            window.rootViewController = initialViewController
            return window
        }
        return nil
    }
    
}
