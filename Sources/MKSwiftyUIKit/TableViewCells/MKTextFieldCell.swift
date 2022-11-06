import UIKit

open class MKTextFieldCell: MKSwiftySetupUITableViewCell {
    
    public let textField = MKClosureUITextField()
    
    open override func setup() {
        contentView.addSubviewConstrainingToLayoutGuide(textField)
        hitTestingView = textField
    }
 
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if textField.frame.contains(point) {
            return super.hitTest(point, with: event)
        }
        return nil
    }
}
