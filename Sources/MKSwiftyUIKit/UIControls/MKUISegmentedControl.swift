import UIKit

open class MKUISegmentedControl: UISegmentedControl {
    
    open var valueChangedHandler: ((MKUISegmentedControl) -> Void)?
    
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
        addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    open func setup() { }
    
    @objc private func segmentValueChanged() {
        valueChangedHandler?(self)
    }
}


public extension MKUISegmentedControl {
    
    /// Fluent API for setting `valueChangedHandler(_:)`.
    
    @discardableResult
    func onValueChanged(_ handler: @escaping (MKUISegmentedControl) -> Void) -> Self {
        valueChangedHandler = handler
        return self
    }
    
}
