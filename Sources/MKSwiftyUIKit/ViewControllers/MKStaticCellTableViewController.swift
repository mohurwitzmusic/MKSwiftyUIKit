import UIKit


open class MKStaticCellTableViewController: UITableViewController {
    
    public typealias DiffableDataSource = UITableViewDiffableDataSource<MKStaticCellTableViewSection, UITableViewCell>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<MKStaticCellTableViewSection, UITableViewCell>
    
    open lazy var dataSource: DiffableDataSource = {
        return .init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            return itemIdentifier
        }
    }()
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource.snapshot().sectionIdentifiers[section].header
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        dataSource.snapshot().sectionIdentifiers[section].footer
    }
    
    
}


open class MKStaticCellTableViewSection: NSObject {
    open var header: UITableViewHeaderFooterView?
    open var cells: [UITableViewCell] = []
    open var footer: UITableViewHeaderFooterView?
}

extension NSDiffableDataSourceSnapshot
where SectionIdentifierType == MKStaticCellTableViewSection,
      ItemIdentifierType == UITableViewCell {
    public init(sections: [MKStaticCellTableViewSection]) {
        self.init()
        for section in sections {
            self.appendSections([section])
            self.appendItems(section.cells, toSection: section)
        }
    }
}


