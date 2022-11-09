import UIKit

open class MKSliderLabelCell: MKSwiftySetupUITableViewCell {
    
    public let hStack = UIStackView(axis: .horizontal, spacing: 20)
    public let slider = MKClosureUISlider()
    public let titleLabel = UILabel(text: "Title", alignment: .right)
    public let valueLabel = UILabel(text: "0.0", font: .preferredFont(forTextStyle: .caption1))
    
    open override func setup() {
        contentView.addSubviewConstrainingToLayoutGuide(hStack)
        hStack.addArrangedSubviews([titleLabel, slider, valueLabel])
        slider.constrainWidth(.equalTo(widthAnchor), multiplier: 0.7)
        valueLabel.constrainWidth(.equalToConstant(30), priority: .required)
        valueLabel.setHorizontalLayoutPriority(compression: .defaultLow, hugging: .defaultLow)
        slider.setHorizontalLayoutPriority(compression: .required, hugging: .required)
        hitTestingView = slider
        selectionStyle = .none
    }

    
    
}

