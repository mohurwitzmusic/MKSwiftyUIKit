import UIKit

open class MKClosureUITextField: UITextField, UITextFieldDelegate {
    
    open var shouldReturn: ((UITextField) -> Bool)?
    open var didEndEditing: ((UITextField) -> Void)?
    open var shouldEndEditing: ((UITextField) -> Bool)?
    open var shouldChangeCharactersInRange: ((UITextField, NSRange, String) -> Bool)?
    
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
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.shouldReturn?(self) ?? true
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(self)
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.shouldEndEditing?(self) ?? true
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.shouldChangeCharactersInRange?(self, range, string) ?? true
    }
    
    
}

public extension MKClosureUITextField {
    
    @discardableResult
    func onShouldReturn( _ handler: @escaping ((UITextField) -> Bool)) -> Self {
        self.shouldReturn = handler
        return self
    }
    
    @discardableResult
    func onShouldEndEditing( _ handler: @escaping ((UITextField) -> Bool)) -> Self {
        self.shouldEndEditing = handler
        return self
    }
    
    @discardableResult
    func onDidEndEditing(_ handler: @escaping ((UITextField) -> Void)) -> Self {
        self.didEndEditing = handler
        return self
    }
    
    @discardableResult
    func onShouldChangeCharactersInRange(_ handler: @escaping ((UITextField, NSRange, String) -> Bool)) -> Self {
        self.shouldChangeCharactersInRange = handler
        return self
    }

}


