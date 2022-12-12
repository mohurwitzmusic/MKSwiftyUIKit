import UIKit

public extension UITableView {
    
    func deselectRow(at indexPath: IndexPath, animated: Bool, callDidDeselectRow: Bool) {
        deselectRow(at: indexPath, animated: animated)
        if callDidDeselectRow {
            delegate?.tableView?(self, didDeselectRowAt: indexPath)
        }
    }
    
}


@available(*, deprecated, renamed: "UITableView.deselectRow(at:animated:callDidDeselectRow:)")
public extension UITableView {
    
    func deselectRowAndCallDidDeselect(at indexPath: IndexPath, animated: Bool = true) {
        deselectRow(at: indexPath, animated: animated)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
    
}
