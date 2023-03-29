import UIKit
import Combine

open class MKUISlider: UISlider {
    
    open var valueChangedHandler: ((MKUISlider) -> Void)?
    open var touchDownHandler: ((MKUISlider) -> Void)?
    open var touchUpInsideHandler: ((MKUISlider) -> Void)?
    open var touchUpOutsideHandler: ((MKUISlider) -> Void)?
    
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
        addTarget(self, action: #selector(_onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(_onTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(_onTouchUpOutside), for: .touchUpOutside)
    }
    
    open func setup() {

    }
        
    @objc private func _onValueChanged() {
        valueChangedHandler?(self)
    }
    
    @objc private func _onTouchDown() {
        touchDownHandler?(self)
    }
    
    @objc private func _onTouchUpInside() {
        touchUpInsideHandler?(self)
    }
    
    @objc private func _onTouchUpOutside() {
        touchUpOutsideHandler?(self)
    }
    
}


public extension MKUISlider {
    
  
    /// Fluent API for setting `valueChangedHandler(_:)`.
    
    @discardableResult
    func onValueChanged(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        valueChangedHandler = handler
        return self
    }

    /// Fluent API for setting `touchDownHandler(_:)`.

    @discardableResult
    func onTouchDown(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchDownHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchUpInsideHandler(_:)`.

    @discardableResult
    func onTouchUpInside(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchUpInsideHandler = handler
        return self
    }
    
    /// Fluent API for setting `touchUpOutsideHandler(_:)`.

    @discardableResult
    func onTouchUpOutside(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchUpOutsideHandler = handler
        return self
    }
    
    /// Fluent API for setting both `touchUpInsideHandler(_:)` and `touchUpOutsideHandler(_:)` to the same handler.
    
    @discardableResult
    func onTouchUpInsideOutside(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchUpInsideHandler = handler
        touchUpOutsideHandler = handler
        return self
    }

}

