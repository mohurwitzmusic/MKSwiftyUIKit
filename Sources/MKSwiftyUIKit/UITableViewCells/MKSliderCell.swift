import UIKit

public struct MKSliderCellViewModel: Equatable {
    public var value: Float = 0.0
    public var isEnabled = true
    public init() { }
}

open class MKSliderCell: MKFormCell {

    open var slider = MKUISlider()
    
    open override func setup() {
        selectionStyle = .none
        contentView.addSubview(slider)
        slider.constrainToLayoutGuide(contentView.layoutMarginsGuide)
    }
    
    open func refresh(viewModel: MKSliderCellViewModel, animated: Bool) {
        self.slider.setValue(viewModel.value, animated: animated)
        slider.isEnabled = viewModel.isEnabled
        isUserInteractionEnabled = viewModel.isEnabled
    }
}

