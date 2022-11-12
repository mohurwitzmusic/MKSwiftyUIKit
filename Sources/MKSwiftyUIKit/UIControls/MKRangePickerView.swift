import UIKit

// BETA

internal class MKRangePickerView<T: BinaryInteger>: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum ScrollDirection {
        case lowToHigh
        case highToLow
    }

    final let range: ClosedRange<T>
    final let scrollDirection: ScrollDirection
    private(set) var linkSelection = false

    var selectedRange: ClosedRange<T> {
        valueForRow(selectedRow(inComponent: 0))...valueForRow(selectedRow(inComponent: 1))
    }

    var selectionDidChangeHandler: ((ClosedRange<T>) -> Void)?
    
    init(range: ClosedRange<T>, scrollDirection: ScrollDirection = .highToLow) {
        self.range = range
        self.scrollDirection = scrollDirection
        super.init(frame: .zero)
        delegate = self
        dataSource = self
        reloadAllComponents()
        updateSelectedRows(min: range.lowerBound, max: range.upperBound, animated: false)
    }
    
    func selectLowerBound(_ min: T, animated: Bool = false) {
        let attemptedMin = min
        let oldMax = self.max
        let min = range.clamp(min)
        var max = max
        if linkSelection || max < min {
            max = min
        }
        updateSelectedRows(min: min, max: max, animated: animated)
        if max != oldMax || attemptedMin != min {
            selectionDidChangeHandler?(selectedRange)
        }
    }
    
    func selectUpperBound(_ max: T, animated: Bool = false) {
        let attemptedMax = max
        let oldMin = min
        let max = range.clamp(max)
        var min = min
        if linkSelection || min > max {
            min = max
        }
        updateSelectedRows(min: min, max: max, animated: animated)
        if oldMin != min || attemptedMax != max {
            selectionDidChangeHandler?(selectedRange)
        }
    }

    
    func selectRange(lowerBound: T, upperBound: T, animated: Bool = false) {
        let attemptedMin = min
        let attemptedMax = max
        let newMin = range.clamp(min)
        var newMax = range.clamp(max)
        if linkSelection && newMin != newMax {
            linkSelection = false
        }
        if newMin > newMax {
            newMax = newMin
        }
        updateSelectedRows(min: newMin, max: newMax, animated: animated)
        if min != attemptedMin || max != attemptedMax {
            selectionDidChangeHandler?(selectedRange)
        }
    }
    
    func setIsLinkSelectionEnabled(_ enabled: Bool, animated: Bool) {
        self.linkSelection = enabled
        let oldMax = self.max
        if enabled {
            updateSelectedRows(min: min, max: min, animated: animated)
        }
        if oldMax != max {
            selectionDidChangeHandler?(selectedRange)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    final func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    final func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        range.lowerBound.distance(to: range.upperBound) + 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(valueForRow(row))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = valueForRow(row)
        if component == 0 {
            selectLowerBound(value, animated: false)
        } else {
            selectUpperBound(value, animated: false)
        }
    }
    
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let value = valueForRow(row)
        if component == 0 {
            selectLowerBound(value, animated: animated)
        } else {
            selectUpperBound(value, animated: animated)
        }
    }
    
    func valueForRow(_ row: Int) -> T {
        switch scrollDirection {
        case .highToLow:
            return range.clamp(range.upperBound - T(row))
        case .lowToHigh:
            return range.clamp(range.lowerBound + T(row))
        }
    }
    
    func rowForValue(_ value: T) -> Int {
        let value = range.clamp(value)
        let offset = Int(range.lowerBound.distance(to: value))
        switch scrollDirection {
        case .lowToHigh:
            return Int(offset)
        case .highToLow:
            return range.lowerBound.distance(to: range.upperBound) - offset
        }
    }
    
    private func updateSelectedRows(min: T, max: T, animated: Bool) {
        super.selectRow(rowForValue(min), inComponent: 0, animated: animated)
        super.selectRow(rowForValue(max), inComponent: 1, animated: animated)
    }
    
    private func log(_ msg: String = "") {
        print("min: \(min), max: \(max), linked: \(linkSelection), msg: '\(msg)'")
    }
    
    private var min: T {
        valueForRow(selectedRow(inComponent: 0))
    }
    
    private var max: T {
        valueForRow(selectedRow(inComponent: 1))
    }

}

fileprivate extension ClosedRange {
    func clamp(_ value: Bound) -> Bound {
        return Swift.min(Swift.max(value, lowerBound), upperBound)
    }
}
