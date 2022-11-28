import UIKit
import Combine

open class MKUISlider: UISlider {
    
    open var valueChangedHandler: ((MKUISlider) -> Void)?
    open var touchesBeganHandler: ((MKUISlider) -> Void)?
    open var touchesEndedHandler: ((MKUISlider) -> Void)?
    open var observedObject: AnyCancellable?
    
    
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
        addTarget(self, action: #selector(_onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(_onTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(_onTouchUp), for: .touchUpOutside)
    }
    
    @objc private func _onValueChanged() {
        valueChangedHandler?(self)
    }
    
    @objc private func _onTouchDown() {
        touchesBeganHandler?(self)
    }
    
    @objc private func _onTouchUp() {
        touchesEndedHandler?(self)
    }
    
}


public extension MKUISlider {
    
    @discardableResult
    func configure<T: AnyObject>(target: T, _ handler: ((T, MKUISlider) -> Void)) -> Self {
        handler(target, self)
        return self
    }
    
    @discardableResult
    func onValueChanged(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        valueChangedHandler = handler
        return self
    }
    
    @discardableResult
    func onValueChanged<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUISlider) -> Void)) -> Self {
        valueChangedHandler = { [weak target] slider in
            if let target {
                handler(target, slider)
            }
        }
        return self
    }
    
    @discardableResult
    func onTouchesBegan(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchesBeganHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchesBegan<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUISlider) -> Void)) -> Self {
        touchesBeganHandler = { [weak target] slider in
            if let target {
                handler(target, slider)
            }
        }
        return self
    }
    
    @discardableResult
    func onTouchesEnded(_ handler: @escaping ((MKUISlider) -> Void)) -> Self {
        touchesEndedHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchesEnded<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUISlider) -> Void)) -> Self {
        touchesEndedHandler = { [weak target] slider in
            if let target {
                handler(target, slider)
            }
        }
        return self
    }
    
    @discardableResult
    func onObjectWillChange<T: ObservableObject>(_ object: T, handler: @escaping ((T, MKUISlider) -> Void)) -> Self {
        observedObject = object.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak object, weak self] _ in
            guard let object, let self else { return }
            handler(object, self)
        }
        return self
    }
}

