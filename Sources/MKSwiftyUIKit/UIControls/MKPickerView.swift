import UIKit
import Combine

open class MKPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    open var numberOfComponentsHandler: ((MKPickerView) -> Int)?
    open var numberOfRowsInComponentHandler: ((MKPickerView, Int) -> Int)?
    open var titleForRowForComponentHandler: ((MKPickerView, Int, Int) -> String?)?
    open var rowSelectionHandler: ((MKPickerView, Int, Int) -> ())?
    open var rowHeightForComponentHandler: ((MKPickerView, Int) -> CGFloat)?
    open var observedObject: AnyCancellable?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.privateSetup()
        self.setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.privateSetup()
        self.setup()
    }
    
    private func privateSetup() {
        self.delegate = self
        self.dataSource = self
    }
    
    open func setup() { }
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.numberOfComponentsHandler?(self) ?? 0
    }
    
    open func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if let rowHeightForComponentHandler {
            return rowHeightForComponentHandler(self, component)
        }
        if frame.height < 40 {
            return max(frame.height - 12, 5)
        }
        return 40
    }

    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.numberOfRowsInComponentHandler?(self, component) ?? 0
    }

    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.titleForRowForComponentHandler?(self, row, component)
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelectionHandler?(self, row, component)
    }
    
}


public extension MKPickerView {
    
    @discardableResult
    func onNumberOfComponents(_ handler: ((MKPickerView) -> Int)?) -> Self{
        self.numberOfComponentsHandler = handler
        return self
    }
    
    @discardableResult
    func onNumberOfComponents<T: AnyObject>(target: T, _ handler: @escaping ((T, MKPickerView) -> Int)) -> Self{
        self.numberOfComponentsHandler = { [weak target] pickerView in
            if let target {
                return handler(target, pickerView)
            } else {
                return 0
            }
        }
        return self
    }
    
    @discardableResult
    func onNumberOfRowsInComponent(_ handler: ((MKPickerView, Int) -> Int)?) -> Self {
        self.numberOfRowsInComponentHandler = handler
        return self
    }
    
    @discardableResult
    func onNumberOfRowsInComponent<T: AnyObject>(target: T, _ handler: @escaping ((T, MKPickerView, Int) -> Int)) -> Self {
        self.numberOfRowsInComponentHandler = { [weak target] picker, component in
            guard let target else { return 0 }
            return handler(target, self, component)
        }
        return self
    }
    
    @discardableResult
    func onTitleForRowForComponent(_ handler: ((MKPickerView, Int, Int) -> String?)?) -> Self {
        self.titleForRowForComponentHandler = handler
        return self
    }
    
    @discardableResult
    func onTitleForRowForComponent<T: AnyObject>(target: T, _ handler: @escaping ((T, MKPickerView, Int, Int) -> String?)) -> Self {
        self.titleForRowForComponentHandler = { [weak target] picker, component, row in
            guard let target else { return nil }
            return handler(target, picker, row, component)
        }
        return self
    }
    
    @discardableResult
    func onDidSelectRow(_ handler: ((MKPickerView, Int, Int) -> ())?) -> Self {
        self.rowSelectionHandler = handler
        return self
    }
    
    @discardableResult
    func onDidSelectRow<T: AnyObject>(target: T, _ handler: @escaping ((T, MKPickerView, Int, Int) -> Void)) -> Self {
        self.rowSelectionHandler = { [weak target] picker, row, component in
            guard let target else { return }
            handler(target, picker, row, component)
        }
        return self
    }
    
    @discardableResult
    func onHeightForRowForComponent(_ handler: ((MKPickerView, Int) -> CGFloat)?) -> Self {
        self.rowHeightForComponentHandler = handler
        return self
    }
    
    @discardableResult
    func onObjectWillChange<T: ObservableObject>(_ object: T, handler: @escaping ((T, MKPickerView) -> Void)) -> Self {
        observedObject = object.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak object, weak self] _ in
            guard let object, let self else { return }
            handler(object, self)
        }
        return self
    }
    
}


public extension MKPickerView {
    
    static func numberPicker(range: ClosedRange<Int>, selected: Int, onSelection: ((Int) -> Void)? = nil) -> MKPickerView {
        guard range.contains(selected) else {
            fatalError("Index out of bounds")
        }
        let p = MKPickerView()
            .onNumberOfComponents { _ in return 1 }
            .onNumberOfRowsInComponent { _, _ in return range.count }
            .onTitleForRowForComponent { _, row, _ in return "\(row)" }
        p.selectRow(range.lowerBound.distance(to: selected), inComponent: 0, animated: false)
        p.onDidSelectRow { _, row, _ in
            let num = range.lowerBound + row
            onSelection?(num)
        }
        return p
        
    }
    

    
}
