import UIKit


/// A generic `UIContentView` for use with `UIContentConfiguration`.
///
/// - Exposes `customConfiguation` as a property which contains the generic configuration type. The built in `configuration` property is then computed off this property.
/// - Do all initial setup in `setup`
/// - Do all updates in `updateConfiguration`
/// - Note: asserts if it can't cast the new configuration to the generic `UIContentConfiguration` type.

open class MKSwiftySetupUIContentView<T: UIContentConfiguration>: UIView, UIContentView {
    
    open var customConfiguration: T
    
    public var configuration: UIContentConfiguration {
        get { customConfiguration }
        set {
            guard let newValue = newValue as? T else {
                assert(false, "Failed to cast content configuration to type \(T.self)")
                return
            }
            self.customConfiguration = newValue
            updateConfiguration()
        }
    }
    
    public init(configuration: T, frame: CGRect = .zero) {
        self.customConfiguration = configuration
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Perform initial setup here. Called once after `init(configuration)`
    
    open func setup() { }
    
    /// Perform updates here. Called every time `configuration` is set.
    
    open func updateConfiguration() { }
}
