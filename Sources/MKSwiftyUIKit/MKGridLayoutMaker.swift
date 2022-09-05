import UIKit

open class MKGridLayoutMaker {
    
    public enum Origin: Int {
        case topLeft = 0
        case topRight
        case bottomLeft
        case bottomRight
        
    }
    
    public enum Configuration: Int {
        case rowByRow
        case columnByColumn
    }
    
    //internal optimization; only make frames when needed
    private var needsMakeFrames: Bool = true
    private var _frames: [CGRect] = []
    
    /// The rectangle in which to calculate the frames
    
    open var bounds: CGRect = CGRect() {
        didSet {
            self.needsMakeFrames = true
        }
    }
    
    /// The number of columns.
    
    open var columns: Int = 1 {
        didSet {
            guard self.columns >= 1 else {
                fatalError("Must specify at least 1 columns")
            }
            self.needsMakeFrames = true
        }
    }
    
    /// The number of rows.
    
    open var rows: Int = 1 {
        didSet {
            guard self.rows >= 1 else {
                fatalError("Must specify at least 1 rows")
            }
            self.needsMakeFrames = true
        }
    }
    
    /// The spacing between rows.
    
    open var rowSpacing: CGFloat = 2 {
        didSet {
            self.needsMakeFrames = true
        }
    }
    
    /// The spacing between columns.
    
    open var columnSpacing: CGFloat = 2 {
        didSet {
            self.needsMakeFrames = true
        }
    }
    
    /// The origin for the zeroeth element.
    
    open var origin: Origin = .topLeft {
        didSet {
            self.needsMakeFrames = true
        }
    }
    
    /// The grid configuration, whether row-by-row, or column-by-column.
    
    open var configuration: Configuration = .rowByRow {
        didSet {
            self.needsMakeFrames = true
        }
    }
    
    /// The width of a single element. Does not include padding.
    
    open var elementWidth: CGFloat {
        return (self.bounds.width - (CGFloat(self.columns - 1) * columnSpacing)) / CGFloat(columns)
    }
    
    /// The height of a single element. Does not include padding.
    
    open var elementHeight: CGFloat {
        return (self.bounds.height - (CGFloat(self.rows - 1) * rowSpacing)) / CGFloat(rows)
    }
    
    /// The number of elements. Calculated by rows * columns.
    
    open var numElements: Int {
        return self.columns * self.rows
    }
    
    /// The generated frames.
    
    open var frames: [CGRect] {
        get {
            //runtime optimization; make frames if needed
            if self.needsMakeFrames {
                self._frames = self.makeFrames()
                self.needsMakeFrames = false
            }
            return self._frames
        }
    }
    
    public init() { }
    
    public init(bounds: CGRect) {
        self.bounds = bounds
    }
    
    /// The element frame at the specified row and column. Uses the current origin and direction
    /// to number rows and columns.
    
    open func frame(row: Int, column: Int) -> CGRect {
        guard row >= 0, row < self.rows, column >= 0, column < self.columns
            else { fatalError("Index out of bounds; row: \(row), column: \(column)")}
        let index: Int
        switch self.configuration{
            case .columnByColumn: index = column * self.rows + row
            case .rowByRow: index = row * self.columns + column
        }
        return self.frames[index]
    }
    
    /// Creates a frame over a range of rows and columns. Uses the current origin and direction
    /// to number rows and columns.
    
    open func frame(rowRange: CountableClosedRange<Int>, columnRange: CountableClosedRange<Int>) -> CGRect {
        guard rowRange.lowerBound >= 0,
            rowRange.lowerBound < self.rows,
            columnRange.upperBound >= 0,
            columnRange.upperBound < self.columns
            else { fatalError("Index out of bounds; rowRange: \(rowRange), columnRange: \(columnRange)") }
        let topLeft: CGRect, topRight: CGRect, botLeft: CGRect
        switch self.origin {
        case .topLeft:
            topLeft = self.frame(row: rowRange.lowerBound, column: columnRange.lowerBound)
            topRight = self.frame(row: rowRange.lowerBound, column: columnRange.upperBound)
            botLeft = self.frame(row: rowRange.upperBound, column: columnRange.lowerBound)
        case .topRight:
            topLeft = self.frame(row: rowRange.lowerBound, column: columnRange.upperBound)
            topRight = self.frame(row: rowRange.lowerBound, column: columnRange.lowerBound)
            botLeft = self.frame(row: rowRange.upperBound, column: columnRange.lowerBound)
        case .bottomLeft:
            topLeft = self.frame(row: rowRange.upperBound, column: columnRange.lowerBound)
            topRight = self.frame(row: rowRange.upperBound, column: columnRange.upperBound)
            botLeft = self.frame(row: rowRange.lowerBound, column: columnRange.lowerBound)
        case .bottomRight:
            topLeft = self.frame(row: rowRange.upperBound, column: columnRange.upperBound)
            topRight = self.frame(row: rowRange.upperBound, column: columnRange.lowerBound)
            botLeft = self.frame(row: rowRange.lowerBound, column: columnRange.upperBound)


        }
        let minX = topLeft.minX
        let maxX = topRight.maxX
        let minY = topLeft.minY
        let maxY = botLeft.maxY
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        
    }
    
    open func apply(to views: [UIView]) {
        guard self.frames.count >= views.count else {
            fatalError("MKGridLayoutMaker apply: not enough frames for the supplied number of views. frames: \(self.frames.count), views: \(views.count)")
        }
        for i in 0..<views.count {
            views[i].frame = self.frames[i]
        }
    }
        
    private func makeFrames() -> [CGRect] {
        switch self.origin {
        case .topLeft:
            switch self.configuration {
            case .columnByColumn: return self.makeTopLeftByColumn()
            case .rowByRow: return self.makeTopLeftByRow()
            }
        case .topRight:
            switch self.configuration {
            case .columnByColumn: return self.makeTopRightByColumn()
            case .rowByRow: return self.makeTopRightByRow()
            }
        case .bottomLeft:
            switch self.configuration {
            case .columnByColumn: return self.makeBottomLeftByColumn()
            case .rowByRow: return self.makeBottomLeftByRow()
            }
        case .bottomRight:
            switch self.configuration {
            case .columnByColumn: return self.makeBottomRightByColumn()
            case .rowByRow: return self.makeBottomRightByRow()
            }
        }
    }
    
    private func makeTopLeftByRow() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.minX + ((w + self.columnSpacing) * CGFloat(i % self.columns))
            let y: CGFloat = self.bounds.minY + ((h + self.rowSpacing) * CGFloat(i / self.columns))
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeTopLeftByColumn() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.minX + (w + self.columnSpacing) * CGFloat(i / self.rows)
            let y: CGFloat = self.bounds.minY + (h + self.rowSpacing) * CGFloat(i % self.rows)
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeTopRightByRow() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.maxX - w - ((w + self.columnSpacing) * CGFloat(i % self.columns))
            let y: CGFloat = self.bounds.minY + ((h + self.rowSpacing) * CGFloat(i / self.columns))
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeTopRightByColumn() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.maxX - w -  (w + self.columnSpacing) * CGFloat(i / self.rows)
            let y: CGFloat = self.bounds.minY + ((h + self.rowSpacing) * CGFloat(i % self.rows))
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeBottomLeftByRow() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.minX + ((w + self.columnSpacing) * CGFloat(i % self.columns))
            let y: CGFloat = self.bounds.maxY - h - (h + self.rowSpacing) * CGFloat(i / self.columns)
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeBottomLeftByColumn() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.minX + ((w + self.columnSpacing) * CGFloat(i / self.rows))
            let y: CGFloat = self.bounds.maxY - h - (h + self.rowSpacing) * CGFloat(i % self.rows)
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeBottomRightByRow() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.maxX - w - (w + self.columnSpacing) * CGFloat(i % self.columns)
            let y: CGFloat = self.bounds.maxY - h - (h + self.rowSpacing) * CGFloat(i / self.columns)
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
    
    private func makeBottomRightByColumn() -> [CGRect] {
        var result = [CGRect]()
        let w = self.elementWidth
        let h = self.elementHeight
        for i in 0..<self.numElements {
            let x: CGFloat = self.bounds.maxX - w - (w + self.columnSpacing) * CGFloat(i / self.rows)
            let y: CGFloat = self.bounds.maxY - h - (h + self.rowSpacing) * CGFloat(i % self.rows)
            result.append(CGRect(x: x, y: y, width: w, height: h))
        }
        return result
    }
}
