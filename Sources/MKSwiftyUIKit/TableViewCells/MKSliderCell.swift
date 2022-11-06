import UIKit

open class MKSliderCell: MKSwiftySetupUITableViewCell {
    
    public let slider = MKClosureUISlider()
    
    open override func setup() {
        contentView.addSubview(slider)
        slider.constrainToLayoutGuide(contentView.layoutMarginsGuide)
        hitTestingView = slider
    }
    
}
