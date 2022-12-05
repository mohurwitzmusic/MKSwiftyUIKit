import UIKit

public class MKTapGestureRecognizer: UITapGestureRecognizer {
    
    public static func create(in view: UIView?, with eventHandler: ((UITapGestureRecognizer) -> Void)?) {
        MKTapGestureRecognizer(in: view, eventHandler)
    }
    
    public var tapGestureHandler: ((UITapGestureRecognizer) -> Void)?
    
    @discardableResult
    private init(in view: UIView?, _ eventHandler: ((UITapGestureRecognizer) -> Void)?) {
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(recognized))
        self.tapGestureHandler = eventHandler
        view?.addGestureRecognizer(self)
    }
    
    @objc private func recognized() {
        tapGestureHandler?(self)
    }
    
}
