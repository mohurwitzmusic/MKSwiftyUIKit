import UIKit

open class ClosureUISwitch: UISwitch {
    
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
        addTarget(self, action: #selector(onValueChanged), for: .valueChanged)
    }

    @objc private func onValueChanged() {
        eventHandler?(isOn)
    }
}

