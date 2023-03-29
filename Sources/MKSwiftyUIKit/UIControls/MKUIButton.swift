import UIKit
import Combine

@available(*, deprecated, renamed: "MKUIButton")
public typealias ClosureUIButton = MKUIButton

open class MKUIButton: UIButton {
    
    private var timeSinceLastTouchUp: Date?
    open var touchDownHandler: ((MKUIButton) -> Void)?
    open var touchUpInsideHandler: ((MKUIButton) -> Void)?
    open var touchUpOutsideHandler: ((MKUIButton) -> Void)?
    open var touchDownRepeatHandler: ((MKUIButton) -> Void)?
    /// Similar to `touchDownRepeat` but the event is sent on touch up.
    open var touchUpRepeatHandler: ((MKUIButton) -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        privateSetup()
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateSetup()
        setup()
    }
    
    private func privateSetup() {
        addTarget(self, action: #selector(_onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(_onTouchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(_onTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(_onTouchDownRepeat), for: .touchDownRepeat)
    }
    
    open func setup() { }
    
    @objc private func _onTouchDown() {
        touchDownHandler?(self)
    }
    
    @objc private func _onTouchUpOutside() {
        touchUpOutsideHandler?(self)
    }
    
    @objc private func _onTouchUpInside() {
        touchUpInsideHandler?(self)
    }
    
    @objc private func _onTouchDownRepeat() {
        touchDownRepeatHandler?(self)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let timeSinceLastTouchUp,
           Date().timeIntervalSince(timeSinceLastTouchUp) < 0.333 {
            touchUpRepeatHandler?(self)
        }
        timeSinceLastTouchUp = Date()
    }
    
}

public extension MKUIButton {
    
    /// Fluent API for setting `touchDownHandler(_:)`.
    

    @discardableResult
    func onTouchDown(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchDownHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchUpInsideHandler(_:)`.
    
    @discardableResult
    func onTouchUpInside(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchUpInsideHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchUpOutsideHandler(_:)`.
    
    @discardableResult
    func onTouchUpOutside(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchUpOutsideHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchDownRepeatHandler(_:)`.
    
    @discardableResult
    func onTouchDownRepeat(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchDownRepeatHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchUpRepeatHandler(_:)`.
    
    @discardableResult
    func onTouchUpRepeat(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchUpRepeatHandler = handler
        return self
    }
    
}
