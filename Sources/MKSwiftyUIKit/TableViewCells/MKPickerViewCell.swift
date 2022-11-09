import UIKit

open class MKPickerViewCell: MKSwiftySetupUITableViewCell {
    
    public let pickerView = MKClosurePickerView()
    
    public convenience init(height: CGFloat) {
        self.init(frame: .zero)
        self.pickerView.constrainHeight(.equalToConstant(height))
    }

    open override func setup() {
        contentView.addSubviewConstrainingToLayoutGuide(pickerView)
        selectionStyle = .none
    }
    
    
}
