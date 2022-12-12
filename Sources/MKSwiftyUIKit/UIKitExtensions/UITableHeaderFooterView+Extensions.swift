import UIKit

public extension UITableViewHeaderFooterView {
    
    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil) {
        self.init(reuseIdentifier: nil)
        var content = configuration ?? UIListContentConfiguration.groupedHeader()
        content.text = title
        content.secondaryText = subtitle
        self.contentConfiguration = content
    }
    
    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil, systemImage: String) {
        self.init(reuseIdentifier: nil)
        var content = configuration ?? UIListContentConfiguration.groupedHeader()
        content.text = title
        content.secondaryText = subtitle
        content.image = .init(systemName: systemImage)
        self.contentConfiguration = content
    }
    
    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil, image: UIImage?) {
        self.init(reuseIdentifier: nil)
        var content = configuration ?? UIListContentConfiguration.groupedHeader()
        content.text = title
        content.secondaryText = subtitle
        content.image = image
        self.contentConfiguration = content
    }

    
}
