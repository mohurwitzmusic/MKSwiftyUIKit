import UIKit

@available(iOS 15.0, *)
public extension UIButton.Configuration {
    
    func withTitle(_ title: String?) -> Self {
        var copy = self
        copy.title = title
        return copy
    }
    
    func withSubtitle(_ subtitle: String?) -> Self {
        var copy = self
        copy.subtitle = subtitle
        return copy
    }
    
    func withImage(systemName: String) -> Self {
        var copy = self
        copy.image = .init(systemName: systemName)
        return copy
    }
    
    func withImagePlacement(_ placement: NSDirectionalRectEdge) -> Self {
        var copy = self
        copy.imagePlacement = placement
        return copy
    }
    
    func withBaseForegroundColor(_ color: UIColor) -> Self {
        var copy = self
        copy.baseForegroundColor = color
        return copy
    }
    
    func withBaseBackgroundColor(_ color: UIColor) -> Self {
        var copy = self
        copy.baseBackgroundColor = color
        return copy
    }

    func withTitleAlignment(_ alignment: UIButton.Configuration.TitleAlignment) -> Self {
        var copy = self
        copy.titleAlignment = alignment
        return copy
    }
    
    func withImagePadding(_ padding: CGFloat) -> Self {
        var copy = self
        copy.imagePadding = padding
        return copy
    }
    
    func withTitlePadding(_ padding: CGFloat) -> Self {
        var copy = self
        copy.titlePadding = padding
        return copy
    }
    
}
