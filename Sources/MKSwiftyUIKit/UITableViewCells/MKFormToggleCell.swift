import UIKit
import Combine


open class MKFormToggleCell: MKFormCell {
    
    open var toggle = MKUISwitch()
    
    open override func setup() {
        selectionStyle = .none
        accessoryView = toggle
    }
}
