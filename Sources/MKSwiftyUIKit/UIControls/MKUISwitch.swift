import UIKit
import Combine

open class MKUISwitch: UISwitch {
    
    open var valueChangedHandler: ((MKUISwitch) -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open func setup() {
        addTarget(self, action: #selector(_onValueChanged), for: .valueChanged)
    }

    @objc private func _onValueChanged() {
        valueChangedHandler?(self)
    }
    
}

public extension MKUISwitch {
    
    @discardableResult
    func configure<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUISwitch) -> Void)) -> Self {
        handler(target, self)
        return self
    }
    
    @discardableResult
    func onValueChanged(_ handler: @escaping ((MKUISwitch) -> Void)) -> Self {
        self.valueChangedHandler = handler
        return self
    }
    
    @discardableResult
    func onValueChanged<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUISwitch) -> Void)) -> Self {
        self.valueChangedHandler = { [weak target] toggle in
            if let target {
                handler(target, toggle)
            }
        }
        return self
    }
    
}


public extension UISwitch {
    
    /// The same function as `setOn(_:animated)` but in a fluent interface.
    
    @discardableResult
    func setIsOn(_ isOn: Bool, animated: Bool = false) -> Self {
        self.setOn(isOn, animated: animated)
        return self
    }
    
}
