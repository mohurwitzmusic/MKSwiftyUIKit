import UIKit

public extension UIButton {
    
    /// Fluent API for settings the button's `configurationUpdateHandler`.
    
    @available(iOS 15.0, *)
    func setConfigurationUpdateHandler(_ handler: @escaping ((UIButton) -> Void)) -> Self {
        self.configurationUpdateHandler = handler
        return self
    }
    
}
