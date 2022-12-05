import UIKit
import Combine

open class MKUITextField: UITextField, UITextFieldDelegate {
        
    public var textFieldShouldReturnHandler: ((MKUITextField) -> Bool)?
    public var textFieldShouldEndEditingHandler: ((MKUITextField) -> Bool)?
    public var textFieldShouldChangeCharactersInRangeHandler: ((MKUITextField, NSRange, String) -> Bool)?
    public var textFieldDidEndEditingHandler: ((MKUITextField) -> Void)?
    public var textFieldDidBeginEditingHandler: ((MKUITextField) -> Void)?
    public var editingChangedHandler: ((MKUITextField) -> Void)?
    public var observedObject: AnyCancellable?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open func setup() {
        delegate = self
        addTarget(self, action: #selector(_editingChanged), for: .editingChanged)
    }
    
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
    
    @discardableResult
    func configure<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Void)) -> Self {
        handler(target, self)
        return self
    }
    
    @discardableResult
    func onTextFieldShouldReturn(_ handler: @escaping ((MKUITextField) -> Bool)) -> Self {
        self.textFieldShouldReturnHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldShouldReturn<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Bool)) -> Self {
        textFieldShouldReturnHandler = { [weak target] textField in
            guard let target else {
                textField.resignFirstResponder()
                return true
            }
            return handler(target, textField)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldShouldEndEditing(_ handler: @escaping ((MKUITextField) -> Bool)) -> Self {
        self.textFieldShouldEndEditingHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldShouldEndEditing<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Bool)) -> Self {
        textFieldShouldEndEditingHandler = { [weak target] textField in
            guard let target else { return true }
            return handler(target, textField)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldShouldChangeCharactersInRange(_ handler: @escaping  ((MKUITextField, NSRange, String) -> Bool)) -> Self {
        self.textFieldShouldChangeCharactersInRangeHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldShouldChangeCharactersInRange<T: AnyObject>(target: T, _ handler: @escaping  ((T, MKUITextField, NSRange, String) -> Bool)) -> Self {
        textFieldShouldChangeCharactersInRangeHandler = { [weak target] textField, range, string in
            guard let target else { return true }
            return handler(target, textField, range, string)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldDidEndEditing(_ handler: @escaping ((MKUITextField) -> Void)) -> Self {
        self.textFieldDidEndEditingHandler = handler
        return self
    }
    
    @discardableResult
    func onTextFieldDidEndEditing<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Void)) -> Self {
        textFieldDidEndEditingHandler = { [weak target] textField in
            guard let target else { return }
            handler(target, textField)
        }
        return self
    }
    
    @discardableResult
    func onTextFieldDidBeginEditing<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Void)) -> Self {
        textFieldDidBeginEditingHandler = { [weak target] textField in
            guard let target else { return }
            handler(target, textField)
        }
        return self
    }
    
    @discardableResult
    func onEditingChanged(_ handler: @escaping ((MKUITextField) -> Void)) -> Self {
        self.editingChangedHandler = handler
        return self
    }
    
    @discardableResult
    func onEditingChanged<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUITextField) -> Void)) -> Self {
        self.editingChangedHandler = { [weak target] textField in
            guard let target else { return }
            handler(target, textField)
        }
        return self
    }
    
    @discardableResult
    func onObjectWillChange<T: ObservableObject>(_ object: T, applyImmediately: Bool = true, handler: @escaping ((T, MKUITextField) -> Void)) -> Self {
        self.observedObject = object.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak object, weak self] _ in
                guard let object, let self else { return }
                handler(object, self)
            }
        if applyImmediately {
            handler(object, self)
        }
        return self
    }

}


