import UIKit
import Combine

open class MKUISwitch: UISwitch {
    
    open var valueChangedHandler: ((MKUISwitch) -> Void)?
    
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
        addTarget(self, action: #selector(_onValueChanged), for: .valueChanged)
    }
    
    open func setup() { }

    @objc private func _onValueChanged() {
        valueChangedHandler?(self)
    }
    
}

public extension MKUISwitch {
    
    /// Fluent API for setting `valueChangedHandler(_:)`

    @discardableResult
    func onValueChanged(_ handler: @escaping ((MKUISwitch) -> Void)) -> Self {
        self.valueChangedHandler = handler
        return self
    }
    
}

public extension UISwitch {
    
    /// Fluent API for `setIsOn(_:animated)`
    
    @discardableResult
    func setIsOn(_ isOn: Bool, animated: Bool = false) -> Self {
        self.setOn(isOn, animated: animated)
        return self
    }
    
}
