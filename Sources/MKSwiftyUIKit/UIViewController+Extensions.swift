//
//  File.swift
//  
//
//  Created by MOH on 2022-08-04.
//

import UIKit

public extension UIViewController {

    func addChildAndView(_ viewController: UIViewController, frame: CGRect?) {
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
    
    func presentOKCancelAlert(title: String?, message: String, style: UIAlertController.Style = .alert, destructive: Bool, okAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let ok = UIAlertAction(title: "OK", style: destructive ? .destructive : .default) { _ in
            okAction?()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

}
