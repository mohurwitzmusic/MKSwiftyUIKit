//
//  File.swift
//  
//
//  Created by MOH on 2022-06-21.
//

import UIKit


public extension UILabel {
    
    convenience init(text: String? = nil, alignment: NSTextAlignment = .natural, textColor: UIColor = .label, font: UIFont = .systemFont(ofSize: UIFont.systemFontSize)) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = alignment
        self.textColor = textColor
        self.font = font
    }
    
    
    @available(*, deprecated, renamed: "UILabel.setText(_:hideIfNil:)")
    @discardableResult
    func setTextAndHideIfNil(_ text: String?) -> Self {
        self.setText(text, hideIfNil: text == nil)
    }
    
    /// Fluent API for setting the label's `text`, optionally hiding the label if  text is `nil`.
    
    @discardableResult
    func setText(_ text: String?, hideIfNil: Bool = false) -> Self {
        self.text = text
        if hideIfNil && text == nil {
            self.isHidden = true
        }
        return self
    }
    
    /// Fluent API for setting the label's `numberOfLines`.
    
    @discardableResult
    func setNumberOfLines(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
    
    /// Fluent API for setting the label's `textColor`.
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    /// Fluent API for setting the label's `textAlignment`.
    
    @discardableResult
    func setTextAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    /// Fluent API for setting the label's `font`.
    
    @discardableResult
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// Fluent API for setting the label's `adjustsFontForContentSizeCategory`.
    
    @discardableResult
    func setAdjustsFontForContentSizeCategory(_ enabled: Bool) -> Self {
        self.adjustsFontForContentSizeCategory = enabled
        return self
    }
    
    /// Fluent API for setting the label's `lineBreakMode`.
    
    @discardableResult
    func setLineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    /// Fluent API for setting the label's `adjustFontSizeToFitWidth`, supplying an optional `minimumScaleFactor`. Defaults to 0.1 (10% the size of the original font size).

    @discardableResult
    func setAdjustsFontSizeToFitWidth(_ enabled: Bool, minimumScaleFactor: CGFloat = 0.1) -> Self {
        self.adjustsFontSizeToFitWidth = enabled
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    /// Fluent API for setting the label's `adjustFontSizeToFitWidth` to scale down to `minimumFontSize`.

    @discardableResult
    func setAdjustsFontSizeToFitWidth(_ enabled: Bool, minimumFontSize: CGFloat) -> Self {
        self.adjustsFontSizeToFitWidth = enabled
        self.minimumScaleFactor = minimumFontSize/self.font.pointSize
        return self
    }

    
}
