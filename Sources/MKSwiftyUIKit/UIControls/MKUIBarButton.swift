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
    
    @discardableResult
    public func onObjectWillChange<T: ObservableObject>(_ object: T, applyImmediately: Bool = true, handler: @escaping ((T, MKUIBarButton) -> Void)) -> Self {
        self.observedObject = object.objectWillChange
            .sink { [weak self, weak object] _ in
                guard let self, let object else { return }
                handler(object, self)
            }
        if applyImmediately {
            handler(object, self)
        }
        return self
    }
    
 
}
