import UIKit

open class MKTextFieldAccessoryCell: MKSwiftySetupUITableViewCell {
    
    public let textField = MKClosureUITextField()
    
    open override func setup() {
        accessoryView = textField
        hitTestingView = textField
        textField.textAlignment = .right
        accessoryLayout.width = .fractional(0.5)
    }
    
}
