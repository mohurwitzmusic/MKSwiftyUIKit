import UIKit

open class MKSwiftySetupUITableViewCell: UITableViewCell {
    
    private var didConfigure = false
    
    /// Use to define the width of an accessory. `layoutSubviews` checks
    /// to see if an `accessoryView` is set and uses `accessoryWidth` to
    /// calculate its size. The view will be centered vertically.
    
    public struct AccessoryWidth: Equatable, Sendable {
        public var max: CGFloat?
        public var size = Size.fractional(0.5)
        public enum Size: Equatable, Sendable {
            case fractional(CGFloat)
            case fixed(CGFloat)
        }
        public init(size: Size = Size.fractional(0.5), max: CGFloat? = nil) {
            self.max = max
            self.size = size
        }
    }
    
    /// The width of the accessory to use during `layoutSubviews`. Setting this
    /// casuses `layoutSubviews` to be called.
    
    open var accessoryWidth = AccessoryWidth() {
        didSet {
            setNeedsLayout()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    /// Override to perform any setup after initialization.
    
    open func setup() { }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutAccessory()
    }
    
    /// Use to provide an initial configuration. This is only called once.
    
    public final func configureOnce(_ configure: @escaping () -> ()) {
        if didConfigure { return }
        didConfigure = true
        configure()
    }
    
    /// Lays out the `accessoryView`. Called in `layoutSubviews`.
    
    open func layoutAccessory() {
        guard let accessoryView else { return }
        var width: CGFloat
        switch accessoryWidth.size {
        case .fixed(let cGFloat):
            width = cGFloat
        case .fractional(let cGFloat):
            width = bounds.width * cGFloat
        }
        if let max = accessoryWidth.max {
            width = min(max, width)
        }
        let maxWidth = bounds.width - directionalLayoutMargins.leading - directionalLayoutMargins.trailing
        width = min(maxWidth, width)
        let height = accessoryView.sizeThatFits(accessoryView.frame.size).height
        accessoryView.frame = .init(x: bounds.maxX - width - directionalLayoutMargins.leading,
                                  y: bounds.midY - height/2,
                                 width: width,
                                 height: height)
    }
    
}


