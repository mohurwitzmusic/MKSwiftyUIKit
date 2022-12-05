import UIKit
import Combine

@available(*, deprecated, renamed: "MKClosureUIButton")
public typealias ClosureUIButton = MKUIButton

open class MKUIButton: UIButton {
    
    open var touchDownHandler: ((MKUIButton) -> Void)?
    open var touchUpInsideHandler: ((MKUIButton) -> Void)?
    open var touchUpOutsideHandler: ((MKUIButton) -> Void)?
    open var touchDownRepeatHandler: ((MKUIButton) -> Void)?
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
        addTarget(self, action: #selector(_onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(_onTouchUpOutside), for: .touchUpOutside)
        addTarget(self, action: #selector(_onTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(_onTouchDownRepeat), for: .touchDownRepeat)
    }
    
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
    
}

public extension MKUIButton {
    
    @discardableResult
    func configure<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        handler(target, self)
        return self
    }
    
    @discardableResult
    func onTouchDown(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchDownHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchDown<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        touchDownHandler = { [weak target] button in
            guard let target else { return }
            handler(target, button)
        }
        return self
    }
    
    @discardableResult
    func onTouchUpInside(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchUpInsideHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchUpInside<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        touchUpInsideHandler = { [weak target] button in
            guard let target else { return }
            handler(target, button)
        }
        return self
    }
    
    @discardableResult
    func onTouchUpOutside(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchUpOutsideHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchUpOutside<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        touchUpOutsideHandler = { [weak target] button in
            guard let target else { return }
            handler(target, button)
        }
        return self
    }
    
    @discardableResult
    func onTouchDownRepeat(_ handler: @escaping ((MKUIButton) -> Void)) -> Self {
        touchDownRepeatHandler = handler
        return self
    }
    
    @discardableResult
    func onTouchDownRepeat<T: AnyObject>(target: T, _ handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        touchDownRepeatHandler = { [weak target] button in
            guard let target else { return }
            handler(target, button)
        }
        return self
    }
    
    @discardableResult
    func onObjectWillChange<T: ObservableObject>(_ object: T, applyImmediately: Bool = true, handler: @escaping ((T, MKUIButton) -> Void)) -> Self {
        observedObject = object.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak object, weak self] _ in
            guard let object, let self else { return }
            handler(object, self)
        }
        if applyImmediately {
            handler(object, self)
        }
        return self
    }
}
