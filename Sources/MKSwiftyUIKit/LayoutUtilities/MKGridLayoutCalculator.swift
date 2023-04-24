import UIKit

public struct MKGridLayoutCalculator {

    public var rows: Int = 0
    public var columns: Int = 0
    public var bounds: CGRect = .zero
    public var rowSpacing: CGFloat = 2
    public var columnSpacing: CGFloat = 2
    
    public enum Origin {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    public enum Direction {
        case columnByColumn
        case rowByRow
    }
    
    public init(bounds: CGRect) {
        self.bounds = bounds
    }
    
    public init(bounds: CGRect, rows: Int, columns: Int, spacing: CGFloat) {
        self.bounds = bounds
        self.rows = rows
        self.columns = columns
        self.rowSpacing = spacing
        self.columnSpacing = spacing
    }
    
    public var itemWidth: CGFloat {
        guard columns >= 0 else { return .zero }
        return (self.bounds.width - (CGFloat(self.columns - 1) * columnSpacing)) / CGFloat(columns)
    }
    
    public var itemHeight: CGFloat {
        guard rows >= 0 else { return .zero }
        return (self.bounds.height - (CGFloat(self.rows - 1) * rowSpacing)) / CGFloat(rows)
    }
    
    public func frameFor(row: Int, column: Int) -> CGRect {
        guard row >= 0, row < rows else {
            fatalError("Row \(row) index out of bounds")
        }
        guard column >= 0, column < columns else {
            fatalError("Column \(column) index out bounds")
        }
        guard rows >= 0 || columns >= 0 else {
            return .zero
        }
        let w = itemWidth
        let h = itemHeight
        let x: CGFloat = self.bounds.minX + ((w + self.columnSpacing) * CGFloat(column))
        let y: CGFloat = self.bounds.minY + ((h + self.rowSpacing) * CGFloat(row))
        return .init(x: x, y: y, width: w, height: h)
    }
    
    public func frameForItem(atIndex index: Int, gridOrigin: Origin = .topLeft, layoutDirection: Direction = .rowByRow) -> CGRect {
        guard index >= 0 && index < rows * columns else {
            fatalError("Index \(index) out of bounds")
        }
        var row: Int
        var column: Int
        switch layoutDirection {
        case .columnByColumn:
            row = index % rows
            column = index / rows
        case .rowByRow:
            column = index % columns
            row = index / columns
        }
        switch gridOrigin {
        case .topLeft:
            break
        case .topRight:
            column = columns - 1 - column
        case .bottomLeft:
            row = rows - 1 - row
        case .bottomRight:
            row = rows - 1 - row
            column = columns - 1 - column
        }
        return frameFor(row: row, column: column)
    }

}
