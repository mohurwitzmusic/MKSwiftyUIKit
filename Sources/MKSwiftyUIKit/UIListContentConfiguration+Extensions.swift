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
        return copy
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
        return copy
    }
    
    func layoutMargins(_ margins: NSDirectionalEdgeInsets) -> Self {
        var copy = self
        copy.directionalLayoutMargins = margins
        return copy
    }
    
    func preferredSymbolConfiguration(_ config: UIImage.SymbolConfiguration) -> Self {
        var copy = self
        copy.imageProperties.preferredSymbolConfiguration = config
        return copy
    }
    
    func topMargin(_ margin: CGFloat) -> Self {
        var copy = self
        copy.directionalLayoutMargins.top = margin
        return copy
    }
    
    
    func leadingMargin(_ margin: CGFloat) -> Self {
        var copy = self
        copy.directionalLayoutMargins.leading = margin
        return copy
    }
    
    func trailingMargin(_ margin: CGFloat) -> Self {
        var copy = self
        copy.directionalLayoutMargins.trailing = margin
        return copy
    }
    
    func bottomMargin(_ margin: CGFloat) -> Self {
        var copy = self
        copy.directionalLayoutMargins.bottom = margin
        return copy
    }
}

