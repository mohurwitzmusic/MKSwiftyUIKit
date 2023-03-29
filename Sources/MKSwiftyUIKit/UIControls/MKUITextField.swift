import UIKit
import Combine

open class MKUITextField: UITextField, UITextFieldDelegate {
        
    public var textFieldShouldReturnHandler: ((MKUITextField) -> Bool)?
    public var textFieldShouldEndEditingHandler: ((MKUITextField) -> Bool)?
    public var textFieldShouldChangeCharactersInRangeHandler: ((MKUITextField, NSRange, String) -> Bool)?
    public var textFieldDidEndEditingHandler: ((MKUITextField) -> Void)?
    public var textFieldDidBeginEditingHandler: ((MKUITextField) -> Void)?
    public var editingChangedHandler: ((MKUITextField) -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _privateSetup()
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        _privateSetup()
        setup()
    }
    
    private func _privateSetup() {
        delegate = self
        addTarget(self, action: #selector(_editingChanged), for: .editingChanged)
    }
    
    open func setup() { }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let handler = textFieldShouldReturnHandler {
            return handler(self)
        } else {
            resignFirstResponder()
            return true
        }
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditingHandler?(self)
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textFieldShouldEndEditingHandler?(self) ?? true
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textFieldShouldChangeCharactersInRangeHandler?(self, range, string) ?? true
    }
    
    @objc private func _editingChanged() {
        editingChangedHandler?(self)
    }
    
}


public extension MKUITextField {
    
    /// Fluent API fot setting `textFieldShouldReturn(_:)` handler.
    
    @discardableResult
    func onTextFieldShouldReturn(_ handler: @escaping ((MKUITextField) -> Bool)) -> Self {
        self.textFieldShouldReturnHandler = handler
        return self
    }
    
    /// Fluent API fot setting `textFieldShouldEndEditingHandler(_:)` handler.
    
    @discardableResult
    func onTextFieldShouldEndEditing(_ handler: @escaping ((MKUITextField) -> Bool)) -> Self {
        self.textFieldShouldEndEditingHandler = handler
        return self
    }

    /// Fluent API fot setting `textFieldShouldChandeCharactersInRangeHandler(_:)` handler.
    
    @discardableResult
    func onTextFieldShouldChangeCharactersInRange(_ handler: @escaping  ((MKUITextField, NSRange, String) -> Bool)) -> Self {
        self.textFieldShouldChangeCharactersInRangeHandler = handler
        return self
    }
    
    /// Fluent API fot setting `textFieldDidEndEditingHandler(_:)` handler.
    
    @discardableResult
    func onTextFieldDidEndEditing(_ handler: @escaping ((MKUITextField) -> Void)) -> Self {
        self.textFieldDidEndEditingHandler = handler
        return self
    }
    
    
    /// Fluent API fot setting `onEditingChangedHandler(_:)` handler.
    
    @discardableResult
    func onEditingChanged(_ handler: @escaping ((MKUITextField) -> Void)) -> Self {
        self.editingChangedHandler = handler
        return self
    }

}


