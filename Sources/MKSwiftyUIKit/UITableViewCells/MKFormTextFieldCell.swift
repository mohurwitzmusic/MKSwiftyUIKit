import UIKit

open class MKFormTextFieldCell: MKFormCell, UITextFieldDelegate {
        
    open var textField = MKUITextField()

    public init(size: AccessoryLayout.Size = .automatic) {
        super.init(style: .default, reuseIdentifier: nil)
        switch size {
        case .automatic:
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.constrainToLayoutGuide(layoutMarginsGuide)
        case .fractional(let width):
            accessoryView = textField
            accessoryLayout.width = .fractional(width)
        case .fixed(let width):
            accessoryView = textField
            accessoryLayout.width = .fixed(width)
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func setup() {
        selectionStyle = .none
    }
    
}
