import UIKit
import Combine

open class MKUIBarButton: UIBarButtonItem {
    
    open var observedObject: AnyCancellable?
    
    @discardableResult
    public func onButtonPressed<T: AnyObject>(target: T, handler: @escaping ((T) -> Void)) -> Self {
        self.primaryAction = UIAction { [weak target] _ in
            guard let target else { return }
            handler(target)
        }
        return self
    }
    
 
}
