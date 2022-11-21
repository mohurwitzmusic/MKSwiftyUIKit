import UIKit

open class MKSwiftySetupUIStackView: UIStackView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open func setup() {
        
    }
}

