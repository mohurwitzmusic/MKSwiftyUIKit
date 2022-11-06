import UIKit

public extension UIAlertController {
    
    @discardableResult
    func addAction(title: String, style: UIAlertAction.Style, action: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: action)
        self.addAction(action)
        return self
    }
    
    func present(in viewController: UIViewController, animated: Bool = true) {
        viewController.present(self, animated: animated)
    }
    
    @discardableResult
    func addOKAction(style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.addAction(title: "OK", style: style, action: handler)
        return self
    }
    
    @discardableResult
    func addCancelAction(handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        self.addAction(title: "Cancel", style: .cancel, action: handler)
        return self
    }
    
    @discardableResult
    func textField(_ configurationHandler: @escaping ((UITextField) -> Void),
                   onEditingDidEnd: ((UITextField) -> ())?,
                   onEditingChanged: ((UITextField) -> Void)? = nil) -> Self  {
        addTextField { textField in
            configurationHandler(textField)
            if let onEditingDidEnd {
                textField.addAction(UIAction {
                    if let textField = $0.sender as? UITextField {
                        onEditingDidEnd(textField)
                    }
                }, for: .editingDidEnd)
            }
            if let onEditingChanged {
                textField.addAction( UIAction {
                    if let textField = $0.sender as? UITextField {
                        onEditingChanged(textField)
                    }
                }, for: .editingChanged)
            }
        }
        return self
    }
    
}
