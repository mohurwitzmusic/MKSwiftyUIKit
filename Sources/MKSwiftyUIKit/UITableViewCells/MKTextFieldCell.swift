import UIKit


public struct MKTextFieldCellViewModel: Equatable {
    public struct TextFieldProperties: Equatable {
        public var keyboardType = UIKeyboardType.default
        public init() { }
    }
    public var isEnabled: Bool = true
    public var textFieldText: String?
    public var textFieldPlaceholder: String?
    public var textFieldProperties = TextFieldProperties()
    public var contentConfiguration: UIListContentConfiguration?
    public init() { }
}


open class MKTextFieldCell: MKFormCell, UITextFieldDelegate {
        
    open var textField = MKUITextField()

    public init(size: AccessoryLayout.Size = .automatic) {
        super.init(style: .default, reuseIdentifier: nil)
        switch size {
        case .automatic:
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.constrainToLayoutGuide(contentView.layoutMarginsGuide)
        case .fractional(let width):
            accessoryView = textField
            accessoryLayout.width = .fractional(width)
        case .fixed(let width):
            accessoryView = textField
            accessoryLayout.width = .fixed(width)
        }
    }
    

    open func refresh(viewModel: MKTextFieldCellViewModel) {
        textField.text = viewModel.textFieldText
        textField.placeholder = viewModel.textFieldPlaceholder
        textField.keyboardType = viewModel.textFieldProperties.keyboardType
        if let contentConfiguration = viewModel.contentConfiguration {
            self.contentConfiguration = contentConfiguration
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func setup() {
        selectionStyle = .none
    }
    
}

