import UIKit

open class MKHStack: UIStackView {
    
    public init(distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 0.0, @MKFluentViewBuilder content: () -> [UIView]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        self.axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        translatesAutoresizingMaskIntoConstraints = false
        let views = content()
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    public required init(coder: NSCoder) {
        fatalError()
    }
    
}
