import UIKit


public struct MKSegmentedControlCellViewModel: Equatable {
    public struct Segment: Equatable {
        public var title = ""
        public var image: UIImage?
        public init(title: String) {
            self.title = title
            self.image = nil
        }
        public init(image: UIImage?) {
            if let image {
                self.image = image
            } else {
                self.title = "?"
            }
        }
    }
    public var segments: [Segment] = []
    public var selectedSegmentIndex: Int = 0
    public var isEnabled: Bool = true
}


open class MKSegmentedControlCell: MKFormCell {

    open var segmentedControl = MKUISegmentedControl(frame: .zero)
    
    open override func setup() {
        contentView.addSubview(segmentedControl)
        segmentedControl.constrainToLayoutGuide(contentView.layoutMarginsGuide)
        selectionStyle = .none
        hitTestingView = segmentedControl
    }
    
    open func refresh(viewModel: MKSegmentedControlCellViewModel) {
        segmentedControl.update(segments: viewModel.segments)
        if viewModel.selectedSegmentIndex < segmentedControl.numberOfSegments {
            segmentedControl.selectedSegmentIndex = viewModel.selectedSegmentIndex
        } else {
            segmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        segmentedControl.isEnabled = viewModel.isEnabled
        isUserInteractionEnabled = viewModel.isEnabled
    }

}


private extension UISegmentedControl {
    
    func update(segments: [MKSegmentedControlCellViewModel.Segment]) {
        if segmentsEqual(viewModels: segments) { return }
        removeAllSegments()
        segments.forEach { segment in
            if let image = segment.image {
                insertSegment(with: image, at: numberOfSegments, animated: false)
            } else {
                insertSegment(withTitle: segment.title, at: numberOfSegments, animated: false)
            }
        }
        selectedSegmentIndex = segments.isEmpty ? UISegmentedControl.noSegment : 0
    }
    
    func segmentsEqual(viewModels: [MKSegmentedControlCellViewModel.Segment]) -> Bool {
        guard viewModels.count == numberOfSegments else { return false }
        for i in 0..<viewModels.count {
            if let image = viewModels[i].image {
                guard imageForSegment(at: i) == image else {
                    return false
                }
                continue
            }
            guard titleForSegment(at: i) == viewModels[i].title else {
                return false
            }
        }
        return true
    }
}

