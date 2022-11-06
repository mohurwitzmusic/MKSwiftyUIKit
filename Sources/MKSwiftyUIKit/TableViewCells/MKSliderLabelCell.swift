import UIKit

open class MKSliderLabelCell: MKSwiftySetupUITableViewCell {
    
    let hStack = UIStackView(axis: .horizontal, spacing: 20)
    let slider = MKClosureUISlider()
    let titleLabel = UILabel(text: "Title", alignment: .right)
    let valueLabel = UILabel(text: "0.0", font: .preferredFont(forTextStyle: .caption1))
    
    open override func setup() {
        contentView.addSubviewConstrainingToLayoutGuide(hStack)
        hStack.addArrangedSubviews([titleLabel, slider, valueLabel])
        slider.constrainWidth(.equalTo(widthAnchor), multiplier: 0.7)
        valueLabel.constrainWidth(.equalToConstant(30), priority: .required)
        valueLabel.setHorizontalLayoutPriority(compression: .defaultLow, hugging: .defaultLow)
        slider.setHorizontalLayoutPriority(compression: .required, hugging: .required)
        hitTestingView = slider
    }

    
    
}

