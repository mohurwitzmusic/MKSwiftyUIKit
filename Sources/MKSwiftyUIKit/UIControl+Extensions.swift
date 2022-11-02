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
    
}
