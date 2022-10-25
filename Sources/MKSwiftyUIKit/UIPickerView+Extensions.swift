import UIKit

public extension UIPickerView {
    
    func setDelegateAndDataSource(_ item: UIPickerViewDelegate & UIPickerViewDataSource) {
        delegate = item
        dataSource = item
    }
    
}
