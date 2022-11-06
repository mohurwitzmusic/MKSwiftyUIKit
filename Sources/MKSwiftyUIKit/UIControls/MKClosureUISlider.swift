import UIKit

open class MKClosureUISlider: UISlider {
    
    public enum Event: Hashable {
        case touchDown
        case touchUp
        case valueChanged
    }
    
    open var eventHandler: ((Event, Float) -> Void)?
    
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
        addTarget(self, action: #selector(onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(onTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(onTouchUp), for: .touchUpOutside)
    }

    @objc private func onValueChanged() {
        eventHandler?(.valueChanged, value)
    }
    
    @objc private func onTouchDown() {
        eventHandler?(.touchDown, value)
    }
    
    @objc private func onTouchUp() {
        eventHandler?(.touchUp, value)
    }
    
}
