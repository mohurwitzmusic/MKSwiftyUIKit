import UIKit

open class MKZStack: UIView {
    
    public init(@MKFluentViewBuilder content: (UIView) -> [UIView]) {
        super.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        content(self).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            if !subviews.contains($0) {
                addSubview($0)
            }
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError()
    }
}
