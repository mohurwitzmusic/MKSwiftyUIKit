import UIKit

@available(*, deprecated, renamed: "MKClosureUIButton")
public typealias ClosureUIButton = MKClosureUIButton

open class MKClosureUIButton: UIButton {
    
    public enum Event: Hashable {
        case touchDown
        case touchUpInside
        case touchUpOutside
        case touchDownRepeat
    }
    
    open var eventHandler: ((Event) -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open func setup() {
        addTarget(self, action: #selector(onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(onTouchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(onTouchDownRepeat), for: .touchDownRepeat)
    }
    
    @objc private func onTouchDown() {
        eventHandler?(.touchDown)
    }
    
    @objc private func onTouchUpOutside() {
        eventHandler?(.touchUpOutside)
    }
    
    @objc private func onTouchUpInside() {
        eventHandler?(.touchUpInside)
    }
    
    @objc private func onTouchDownRepeat() {
        eventHandler?(.touchDownRepeat)
    }
    
}
