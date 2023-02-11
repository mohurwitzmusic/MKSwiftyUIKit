import UIKit

open class MKSwiftySetupUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    open func setup() {}
    
}
