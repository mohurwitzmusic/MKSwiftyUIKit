import UIKit

open class MKClosureCustomPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    open var numberOfComponentsHandler: ((UIPickerView) -> Int)?
    open var numberOfRowsInComponentHandler: ((UIPickerView, Int) -> Int)?
    open var viewForRowForComponentHandler: ((UIPickerView, Int, Int, UIView?) -> UIView)?
    open var rowSelectionHandler: ((UIPickerView, Int, Int) -> ())?
    open var rowHeightForComponentHandler: ((UIPickerView, Int) -> CGFloat)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    func setup() {
        self.setDelegateAndDataSource(self)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.numberOfComponentsHandler?(pickerView) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if let rowHeightForComponentHandler {
            return rowHeightForComponentHandler(pickerView, component)
        }
        if frame.height < 40 {
            return max(frame.height - 12, 5)
        }
        return 40
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.numberOfRowsInComponentHandler?(pickerView, component) ?? 0
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelectionHandler?(pickerView, row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        viewForRowForComponentHandler?(pickerView, row, component, view) ?? UIView()
    }
}

public extension MKClosureCustomPickerView {
    
    @discardableResult
    func onNumberOfComponents(_ handler: ((UIPickerView) -> Int)?) -> Self{
        self.numberOfComponentsHandler = handler
        return self
    }
    
    @discardableResult
    func onNumberOfRowsInComponent(_ handler: ((UIPickerView, Int) -> Int)?) -> Self {
        self.numberOfRowsInComponentHandler = handler
        return self
    }
    
    @discardableResult
    func onViewForRowForComponentReusingView(_ handler: @escaping ((UIPickerView, Int, Int, UIView?) -> UIView)) -> Self {
        self.viewForRowForComponentHandler = handler
        return self
    }
    
    @discardableResult
    func onDidSelecRow(_ handler: ((UIPickerView, Int, Int) -> ())?) -> Self {
        self.rowSelectionHandler = handler
        return self
    }
    
    @discardableResult
    func onHeightForRowForComponent(_ handler: ((UIPickerView, Int) -> CGFloat)?) -> Self {
        self.rowHeightForComponentHandler = handler
        return self
    }
}

