import UIKit

public extension UITableView {
    
    func deselectRowAndCallDidDeselect(at indexPath: IndexPath, animated: Bool = true) {
        deselectRow(at: indexPath, animated: animated)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
    
}
