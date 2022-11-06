import UIKit

open class MKClosurePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    open var numberOfComponentsHandler: ((UIPickerView) -> Int)?
    open var numberOfRowsInComponentHandler: ((UIPickerView, Int) -> Int)?
    open var titleForRowForComponentHandler: ((UIPickerView, Int, Int) -> String?)?
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

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.titleForRowForComponentHandler?(pickerView, row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelectionHandler?(pickerView, row, component)
    }
}

public extension MKClosurePickerView {
    
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
    func onTitleForRowForComponent(_ handler: ((UIPickerView, Int, Int) -> String?)?) -> Self {
        self.titleForRowForComponentHandler = handler
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


public extension MKClosurePickerView {
    
    @discardableResult
    func configureAsNumberPicker(_ range: Range<Int>, selectionHandler: ((Int) -> Void)?) -> Self {
        self.numberOfComponentsHandler = { _ in return 1}
        self.numberOfRowsInComponentHandler = { _, _ in return range.count }
        self.titleForRowForComponentHandler = { _, row, _ in return "\(row)" }
        self.rowSelectionHandler = { _, row, _ in
            selectionHandler?(row)
        }
        return self
    }
    
    @discardableResult
    func configureWithItems(count: Int, title: ((Int) -> String?)?, selectionHandler: ((Int) -> Void)?) -> Self {
        self.numberOfComponentsHandler = { _ in return 1 }
        self.numberOfRowsInComponentHandler = { _, _ in return count }
        self.titleForRowForComponentHandler = {_, row, _ in return title?(row) }
        self.rowSelectionHandler = { _, row, _ in
            selectionHandler?(row)
        }
        return self
    }
    
    @discardableResult
    func configure<T>(withItems items: [T], titleForRow: ((T) -> String?)?, selectionHandler: ((T) -> Void)?) -> Self {
        self.numberOfComponentsHandler = { _ in return 1 }
        self.numberOfRowsInComponentHandler = {_, _ in return items.count }
        self.titleForRowForComponentHandler = { _, row, _ in
            let item = items[row]
            return titleForRow?(item)
        }
        self.rowSelectionHandler = { _, row, _ in
            let item = items[row]
            selectionHandler?(item)
        }
        return self
    }
    
}

