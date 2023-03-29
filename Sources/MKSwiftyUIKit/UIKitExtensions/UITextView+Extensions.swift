import UIKit

public extension UITextView {
    
    /// Fluent API for setting the text view's `isEditable`.
    
    @discardableResult
    func setIsEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }
    
    /// Fluent API for setting the text view's `isScrollEnabled`.
    
    @discardableResult
    func setIsScrollEnabled(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }
    
    
    /// Fluent API for setting the text view's `textContainerInset`.

    @discardableResult
    func setTextContainerInset(_ inset: UIEdgeInsets) -> Self {
        self.textContainerInset = inset
        return self
    }
    
    /// Fluent API for setting the text view's `text`.
    
    @discardableResult
    func setText(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    /// Fluent API for setting the text view's `font`.
    
    @discardableResult
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// Fluent API for setting the text view's `textColor`.
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    /// Fluent API for setting the text view's `textAlignment`.
    
    @discardableResult
    func setTextAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    /// Fluent API for settings the text view's `isSelectable`.
    
    @discardableResult
    func setIsSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }
}
