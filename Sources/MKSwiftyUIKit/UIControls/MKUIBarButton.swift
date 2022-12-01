import UIKit
import Combine

open class MKUIBarButton: UIBarButtonItem {
    
    open var eventHandler: (() -> Void)?
    open var observedObject: AnyCancellable?
    
    @discardableResult
    public func onButtonPressed<T: AnyObject>(target: T, handler: @escaping ((T) -> Void)) -> Self {
        self.eventHandler = { [weak target] in
            guard let target else { return }
            handler(target)
        }
        return self
    }
    
    @discardableResult
    public func onObjectWillChange<T: ObservableObject>(_ object: T, handler: @escaping ((T, MKUIBarButton) -> Void)) -> Self {
        self.observedObject = object.objectWillChange
            .sink { [weak self, weak object] _ in
                guard let self, let object else { return }
                handler(object, self)
            }
        return self
    }
    
 
}

