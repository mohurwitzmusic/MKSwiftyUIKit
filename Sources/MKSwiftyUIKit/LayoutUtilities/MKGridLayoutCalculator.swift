import UIKit

public struct MKGridLayoutCalculator: Equatable {

    public var rows: Int = 0
    public var columns: Int = 0
    public var bounds: CGRect = .zero
    public var rowSpacing: CGFloat = 2
    public var columnSpacing: CGFloat = 2
    
    public enum Origin: Equatable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    public enum Direction: Equatable {
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
    
    public var cellSize: CGSize {
        guard rows >= 0, columns >= 0 else { return .zero }
        let width = (self.bounds.width - (CGFloat(self.columns - 1) * columnSpacing)) / CGFloat(columns)
        let height = (self.bounds.height - (CGFloat(self.rows - 1) * rowSpacing)) / CGFloat(rows)
        return .init(width: width, height: height)
    }
    
    public func cellSize(rows: Int, columns: Int) -> CGSize {
        guard self.rows >= 0, self.columns >= 0 else { return .zero }
        let rows = CGFloat(rows)
        let columns = CGFloat(columns)
        let size = cellSize
        let width = size.width * columns - ((columns - 1) * columnSpacing)
        let height = size.height * rows - ((rows - 1) * rowSpacing)
        return CGSize(width: width, height: height)
    }

    
    public func frameForCellAt(row: Int, column: Int) -> CGRect {
        guard row >= 0, row < rows else {
            fatalError("Row \(row) index out of bounds")
        }
        guard column >= 0, column < columns else {
            fatalError("Column \(column) index out bounds")
        }
        guard rows >= 0 || columns >= 0 else {
            return .zero
        }
        let cellSize = self.cellSize
        let x: CGFloat = self.bounds.minX + ((cellSize.width + self.columnSpacing) * CGFloat(column))
        let y: CGFloat = self.bounds.minY + ((cellSize.height + self.rowSpacing) * CGFloat(row))
        return .init(origin: .init(x: x, y: y), size: cellSize)
    }
    
    public func frameForCellAt(index: Int, gridOrigin: Origin = .topLeft, layoutDirection: Direction = .rowByRow) -> CGRect {
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
        return frameForCellAt(row: row, column: column)
    }
    
    public func rows(fittingMinimumHeight height: CGFloat) -> Int {
        max(Int((bounds.height + rowSpacing) / (height + rowSpacing)), 0)
    }
    
    public func columns(fittingMinimumWidth width: CGFloat) -> Int {
        max(Int((bounds.width + columnSpacing) / (width + columnSpacing)), 0)
    }

    /// Returns the `IndexPath` containing `point`, optionally rejecting the area in between cells (defaults to `true`)

    public func indexPath(containing point: CGPoint, rejectingSpacing: Bool = true) -> IndexPath? {
        for column in 0..<columns {
            for row in 0..<rows {
                var frame = frameForCellAt(row: row, column: column)
                if !rejectingSpacing {
                    frame = frame.insetBy(dx: -columnSpacing/2, dy: -rowSpacing/2)
                }
                if frame.contains(point) { return .init(row: row, section: column) }
            }
        }
        return nil
    }
    
    /// Returns a set of `IndexPath` objects for all grid cells intersecting the given `CGRect`, optionally reject the area between cells (defaults to `true`)

    public func indexPaths(intersecting rect: CGRect, rejectingSpacing: Bool = true) -> Set<IndexPath> {
        var intersectingIndexPaths = Set<IndexPath>()
        for column in 0..<columns {
            for row in 0..<rows {
                var frame = frameForCellAt(row: row, column: column)
                if !rejectingSpacing {
                    frame = frame.insetBy(dx: -columnSpacing/2, dy: -rowSpacing/2)
                }
                if frame.intersects(rect) {
                    intersectingIndexPaths.insert(.init(row: row, section: column))
                }
            }
        }
        return intersectingIndexPaths
    }
}
