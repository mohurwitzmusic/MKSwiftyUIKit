import UIKit
import Combine

public struct MKToggleCellViewModel: Equatable {
    public var isOn = false
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var isEnabled = true
    public init() { }
}


open class MKToggleCell: MKFormCell {
    
    open var toggle = MKUISwitch()
    
    open override func setup() {
        selectionStyle = .none
        accessoryView = toggle
    }

    open func refresh(viewModel: MKToggleCellViewModel, animated: Bool) {
        self.contentConfiguration = viewModel.contentConfiguration
        toggle.setOn(viewModel.isOn, animated: animated)
        isUserInteractionEnabled = viewModel.isEnabled
        toggle.isEnabled = viewModel.isEnabled
    }

}

