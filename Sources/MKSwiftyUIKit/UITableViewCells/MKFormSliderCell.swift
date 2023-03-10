import UIKit

open class MKFormSliderCell: MKFormCell {

    open var slider = MKUISlider()

    open override func setup() {
        selectionStyle = .none
        contentView.addSubview(slider)
        slider.constrainToLayoutGuide(contentView.layoutMarginsGuide)
    }
}


