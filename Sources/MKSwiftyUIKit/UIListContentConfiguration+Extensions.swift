import UIKit

public extension UIListContentConfiguration {

    func text(_ text: String) -> Self {
        var copy = self
        copy.text = text
        return copy
    }
    
    func secondaryText(_ text: String) -> Self {
        var copy = self
        copy.secondaryText = text
        return copy
    }
    
    func image(systemName: String) -> Self {
        var copy = self
        copy.image = .init(systemName: systemName)
        return copy
    }
    
    func image(_ image: UIImage?) -> Self {
        var copy = self
        copy.image = image
        return copy
    }
    
    func imageTintColor(_ color: UIColor) -> Self {
        var copy = self
        copy.imageProperties.tintColor = color
        return copy
    }
    
    func preferesSideBySideAndSecondaryText(_ prefers: Bool) -> Self {
        var copy = self
        copy.prefersSideBySideTextAndSecondaryText = prefers
        return copy
    }
    
    func symbolConfiguration(_ configuration: UIImage.SymbolConfiguration) -> Self {
        var copy = self
        copy.imageProperties.preferredSymbolConfiguration = configuration
        return copy
    }
    
    func textColor(_ color: UIColor) -> Self {
        var copy = self
        copy.textProperties.color = color
        return copy
    }
    
    func secondaryTextColor(_ color: UIColor) -> Self {
        var copy = self
        copy.secondaryTextProperties.color = color
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        var copy = self
        copy.textProperties.font = font
        return copy
    }
    
    func secondaryFont(_ font: UIFont) -> Self {
        var copy = self
        copy.secondaryTextProperties.font = font
        return copy
    }
    
    func imageToTextPadding(_ padding: CGFloat) -> Self {
        var copy = self
        copy.imageToTextPadding = padding
        return self
    }
    
    func layoutMargins(_ margins: NSDirectionalEdgeInsets) -> Self {
        var copy = self
        copy.directionalLayoutMargins = margins
        return copy
    }
    
}

