import UIKit
import Combine

open class MKUIBarButton: UIBarButtonItem {
        
    @discardableResult
    public func onButtonPressed(handler: @escaping (() -> Void)) -> Self {
        self.primaryAction = UIAction { _ in
            handler()
        }
        return self
    }
    
 
}
