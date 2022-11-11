import UIKit

public class MKCustomPickerViewCell: MKSwiftySetupUITableViewCell {

    public let pickerView = MKClosureCustomPickerView()
    
    public convenience init(height: CGFloat) {
        self.init(frame: .zero)
        self.pickerView.constrainHeight(.equalToConstant(height))
    }

    open override func setup() {
        contentView.addSubviewConstrainingToLayoutGuide(pickerView)
        selectionStyle = .none
    }
    
}
