import UIKit

open class MKToggleCell: MKSwiftySetupUITableViewCell {
    
    public let toggle = MKClosureUISwitch()
    
    open override var isUserInteractionEnabled: Bool {
        didSet {
            toggle.isEnabled = isUserInteractionEnabled
            toggle.isEnabled = isUserInteractionEnabled
        }
    }
    
    open override func setup() {
        self.accessoryView = toggle
        self.hitTestingView = toggle
    }

}
