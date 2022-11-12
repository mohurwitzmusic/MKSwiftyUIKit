// BETA

import UIKit

@IBDesignable
internal class MKHorizontalPickerView: UIView {
    
    private let pickerView = PickerViewDecoratee()
    
    internal var delegate: UIPickerViewDelegate? {
        get { pickerView.delegateWrapper }
        set { pickerView.delegateWrapper = newValue }
    }
    
    internal var dataSource: UIPickerViewDataSource? {
        get { pickerView.dataSourceWrapper }
        set { pickerView.dataSourceWrapper = newValue }
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        privateSetup()
        setup()
    }
    
    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
        privateSetup()
        setup()
    }
    
    private func privateSetup() {
        addSubview(pickerView)
        pickerView.transform = CGAffineTransform(rotationAngle: -.pi/2)
    }
    
    internal func setup() { }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        pickerView.frame = bounds
    }
    
    internal func reloadAllComponents() {
        pickerView.reloadAllComponents()
    }
    
    internal func reloadComponent(_ component: Int) {
        pickerView.reloadComponent(component)
    }
    
    
    internal func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        pickerView.selectRow(row, inComponent: component, animated: animated)
    }
    
    internal func selectedRow(inComponent component: Int) -> Int {
        pickerView.selectedRow(inComponent: component)
    }
    
    internal var numberOfComponents: Int {
        pickerView.numberOfComponents
    }
    
    internal func numberOfRows(inComponent component: Int) -> Int {
        pickerView.numberOfRows(inComponent: component)
    }
    
}

private class PickerViewDecoratee: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegateWrapper: UIPickerViewDelegate?
    weak var dataSourceWrapper: UIPickerViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        dataSourceWrapper?.numberOfComponents(in: pickerView) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataSourceWrapper?.pickerView(pickerView, numberOfRowsInComponent: component) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let view = delegateWrapper?.pickerView?(pickerView, viewForRow: row, forComponent: component, reusing: view) {
            view.transform = CGAffineTransform(rotationAngle: .pi/2)
            return view
        }
        return UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        delegateWrapper?.pickerView?(pickerView, widthForComponent: component) ?? 50
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if let height = delegateWrapper?.pickerView?(pickerView, rowHeightForComponent: component) {
            return height
        }
        let adjustedWidth = bounds.width - 25
        if let components = dataSource?.numberOfComponents(in: self),
           components > 0 {
            return adjustedWidth / CGFloat(components)
        }
        return adjustedWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegateWrapper?.pickerView?(self, didSelectRow: row, inComponent: component)
    }
}

