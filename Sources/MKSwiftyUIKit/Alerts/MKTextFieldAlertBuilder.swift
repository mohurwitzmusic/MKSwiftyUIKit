import UIKit

extension UIAlertController {
    
    public static func textFieldAlert(title: String, message: String) -> MKTextFieldAlertBuilder.AddTextFieldStep {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return MKTextFieldAlertBuilder.AddTextFieldStep(controller: alertVC)
    }
    
}


public enum MKTextFieldAlertBuilder {
        
    public final class AddTextFieldStep {

        private let alertController: UIAlertController
        
        fileprivate init(controller: UIAlertController) {
            self.alertController = controller
        }
        
        public func addTextField(_ configuration: @escaping ((UITextField) -> Void),
                                 onEditingDidBegin: ((UITextField) -> Void)? = nil,
                                 onEditingChanged: ((UITextField) -> Void)? = nil,
                                 onEditingDidEnd: ((UITextField) -> Void)? = nil
        
        ) -> Self {
            alertController.addTextField { textField in
                configuration(textField)
                if let onEditingDidBegin {
                    textField.addAction(UIAction { action in
                        onEditingDidBegin(action.sender as! UITextField)
                    }, for: .editingDidBegin)
                }
                if let onEditingChanged {
                    textField.addAction( UIAction { action in
                        onEditingChanged(action.sender as! UITextField)
                    }, for: .editingChanged)
                }
                if let onEditingDidEnd {
                    textField.addAction( UIAction { action in
                        onEditingDidEnd(action.sender as! UITextField)
                    }, for: .editingDidEnd)
                }
            }
            return self
        }
        
        public func okAction(destructive: Bool = false, _ handler: @escaping (([UITextField]) -> Void)) -> AddCancelStep {
            let action = UIAlertAction(title: "OK", style: destructive ? .destructive : .default) { [weak alertController] _ in
                handler(alertController?.textFields ?? [])
            }
            alertController.addAction(action)
            return AddCancelStep(alertController: alertController)
        }
    }
    
    public final class AddCancelStep {
        private let alertController: UIAlertController
        fileprivate init(alertController: UIAlertController) {
            self.alertController = alertController
        }
        public func cancelAction(_ handler: (() -> Void)? = nil) -> MKTextFieldAlertBuilder.PresentStep {
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
                _ in handler?()
            }))
            return MKTextFieldAlertBuilder.PresentStep(alertController: alertController)
        }
    }
    
    public final class PresentStep {
        private let alertController: UIAlertController
        fileprivate init(alertController: UIAlertController) {
            self.alertController = alertController
        }
        public func present(in viewController: UIViewController, animated: Bool = true) {
            viewController.present(alertController, animated: animated)
        }
    }
    
}
