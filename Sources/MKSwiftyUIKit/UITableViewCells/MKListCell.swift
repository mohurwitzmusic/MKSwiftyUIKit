import UIKit

public struct MKListCellViewModel: Equatable {
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var accessoryType = UITableViewCell.AccessoryType.none
    public var isEnabled = true
    public init() { }
}


open class MKListCell: MKFormCell {
    open func refresh(viewModel: MKListCellViewModel) {
        contentConfiguration = viewModel.contentConfiguration
        isUserInteractionEnabled = viewModel.isEnabled
        accessoryType = viewModel.accessoryType
    }
}
