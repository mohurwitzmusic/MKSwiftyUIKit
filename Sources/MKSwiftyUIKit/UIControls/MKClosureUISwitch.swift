import UIKit

open class MKClosureUISwitch: UISwitch {
    
    open var eventHandler: ((Bool) -> Void)?
    
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
        eventHandler?(isOn)
    }
    
}

public extension MKClosureUISwitch {
    
    @discardableResult
    func onValueChanged(_ eventHandler: @escaping ((Bool) -> Void)) -> Self {
        self.eventHandler = eventHandler
        return self
    }
    
    @discardableResult
    func setIsOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }
}

