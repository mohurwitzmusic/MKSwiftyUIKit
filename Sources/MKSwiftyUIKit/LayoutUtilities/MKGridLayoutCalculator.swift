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
    
    public func rows(fittingMinimumHeight height: CGFloat) -> Int {
        max(Int((bounds.height + rowSpacing) / (height + rowSpacing)), 0)
    }
    
    public func columns(fittingMinimumWidth width: CGFloat) -> Int {
        max(Int((bounds.width + columnSpacing) / (width + columnSpacing)), 0)
    }

    /// Returns the `IndexPath` containing `point`, or `nil` if the point is in a spacing area or outside the grid.

    public func indexPath(containing point: CGPoint) -> IndexPath? {
        let x = point.x - bounds.minX
        let y = point.y - bounds.minY
        let column = Int((x + columnSpacing) / (itemWidth + columnSpacing))
        let row = Int((y + rowSpacing) / (itemHeight + rowSpacing))
        guard row >= 0, row < rows, column >= 0, column < columns else {
            return nil
        }
        return IndexPath(row: row, section: column)
    }
    
    /// Returns the `IndexPath` nearest to `point`, regardless of whether the point is inside a tile or in a spacing area.
    
    public func indexPath(nearest point: CGPoint) -> IndexPath? {
        let x = point.x - bounds.minX
        let y = point.y - bounds.minY
        let column = Int(round(x / (itemWidth + columnSpacing)))
        let row = Int(round(y / (itemHeight + rowSpacing)))
        guard row >= 0, row < rows, column >= 0, column < columns else {
            return nil
        }
        return IndexPath(row: row, section: column)
    }

    /// Returns a set of `IndexPath` objects for all grid cells intersecting the given `CGRect`.

    public func indexPaths(intersecting rect: CGRect) -> Set<IndexPath> {
        let startColumn = max(Int((rect.minX - bounds.minX) / (itemWidth + columnSpacing)), 0)
        let endColumn = min(Int(ceil((rect.maxX - bounds.minX) / (itemWidth + columnSpacing))), columns)
        let startRow = max(Int((rect.minY - bounds.minY) / (itemHeight + rowSpacing)), 0)
        let endRow = min(Int(ceil((rect.maxY - bounds.minY) / (itemHeight + rowSpacing))), rows)
        var indexPaths = Set<IndexPath>()
        for column in startColumn..<endColumn {
            for row in startRow..<endRow {
                let indexPath = IndexPath(row: row, section: column)
                indexPaths.insert(indexPath)
            }
        }
        return indexPaths
    }
    
    /// Returns the `IndexPath` of the grid cell with the largest intersection area with the given `CGRect`.
    
    public func indexPath(nearestIntersection rect: CGRect) -> IndexPath? {
        let intersectingIndexPaths = indexPaths(intersecting: rect)
        guard !intersectingIndexPaths.isEmpty else { return nil }
        var maxOverlapArea: CGFloat = 0.0
        var maxOverlapIndexPath: IndexPath? = nil
        for indexPath in intersectingIndexPaths {
            let cellFrame = frameFor(row: indexPath.row, column: indexPath.section)
            let intersection = rect.intersection(cellFrame)
            let overlapArea = intersection.width * intersection.height
            if overlapArea > maxOverlapArea {
                maxOverlapArea = overlapArea
                maxOverlapIndexPath = indexPath
            }
        }
        return maxOverlapIndexPath
    }

}


