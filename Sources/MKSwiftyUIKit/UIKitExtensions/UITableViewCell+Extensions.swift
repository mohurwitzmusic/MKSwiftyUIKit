import UIKit

public extension UITableViewCell {
    
    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil) {
        self.init(style: .default, reuseIdentifier: nil)
        var content = configuration ?? defaultContentConfiguration()
        content.text = title
        content.secondaryText = subtitle
        self.contentConfiguration = content
    }
    
    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil, systemImage: String) {
        self.init(style: .default, reuseIdentifier: nil)
        var content = configuration ?? defaultContentConfiguration()
        content.text = title
        content.secondaryText = subtitle
        content.image = .init(systemName: systemImage)
        self.contentConfiguration = content
    }

    convenience init(configuration: UIListContentConfiguration? = nil, title: String, subtitle: String? = nil, image: UIImage?) {
        self.init(style: .default, reuseIdentifier: nil)
        var content = configuration ?? defaultContentConfiguration()
        content.text = title
        content.secondaryText = subtitle
        content.image = image
        self.contentConfiguration = content
    }
    
}
