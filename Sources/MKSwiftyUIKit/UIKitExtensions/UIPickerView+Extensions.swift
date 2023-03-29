import UIKit

public extension UIPickerView {
    
    /// Fluent API for setting the picker view's delegate and data source to the same object.
    
    @discardableResult
    func setDelegateAndDataSource(_ delegateAndDataSource: UIPickerViewDelegate & UIPickerViewDataSource) -> Self {
        delegate = delegateAndDataSource
        dataSource = delegateAndDataSource
        return self
    }
    
}
