import UIKit

public extension UIControl {
    
    func removeAllActions() {
        enumerateEventHandlers { action, targetAction, event, stop in
            if let action = action {
                removeAction(action, for: event)
            }
            if let (target, selector) = targetAction {
                removeTarget(target, action: selector, for: event)
            }
            stop = true
        }
    }
    
    func replaceAction(withID id: String, with action: @escaping UIActionHandler, for event: UIControl.Event) {
        self.removeAction(identifiedBy: .init(id), for: event)
        let newAction = UIAction(identifier: .init(id), handler: action)
        addAction(newAction, for: event)
    }
    
    /// Fluent API for setting the view's `isEnabled` property.
    
    @discardableResult
    func setIsEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }
    

}
