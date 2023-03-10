import UIKit

@available(iOS 15, *)
open class MKFormMenuCell<T: Equatable>: MKFormCell {
    
    public struct Menu {
        public var menuTitle = ""
        public var selectedItemTitle = ""
        public var items = [MenuItem]()
        public init() { }
    }
    
    public struct MenuItem: Equatable {
        public let id: T
        public var title: String
        public var isSelected: Bool
        public init(id: T, title: String, isSelected: Bool) {
            self.id = id
            self.title = title
            self.isSelected = isSelected
        }
    }
    
    open var menuButton = UIButton(configuration: .plain())
    open var menu = Menu()
    open var selectionHandler: ((MenuItem) -> Void)?
    
    public override func setup() {
        selectionStyle = .none
        hitTestingView = menuButton
        configureButton()
    }

    private func configureButton() {
        addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            menuButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
        ])
        menuButton.configuration = .plain()
        menuButton.configuration?.imagePlacement = .trailing
        menuButton.configuration?.imagePadding = 5
        menuButton.configuration?.image = .init(systemName: "chevron.up.chevron.down")
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    open override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        let actions = menu.items.map { item in
            item.uiAction {[weak self] id in
                guard let self else { return }
                self.selectionHandler?(item)
            }
        }
        menuButton.menu = UIMenu(children: actions)
        menuButton.configuration?.title = menu.selectedItemTitle
    }

}

@available(iOS 15, *)
public extension MKFormMenuCell.Menu where T : BinaryInteger, T : Comparable, T : Strideable, T.Stride == Int {
    
    static func numberPicker(range: ClosedRange<T>, selected: T) -> MKFormMenuCell<T>.Menu {
        guard range.contains(selected) else {
            fatalError("index \(selected) out of bounds: range=\(range)")
        }
        
        var menu = MKFormMenuCell<T>.Menu()
        menu.items = range.map { value in
                .init(id: value, title: "\(value)", isSelected: value == selected)
        }
        menu.selectedItemTitle = "\(selected)"
        return menu
    }
    
}

@available(iOS 15, *)
fileprivate extension  MKFormMenuCell.MenuItem {
    
    var selectedItemImage: UIImage? {
        UIImage(systemName: "checkmark")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.blue)
    }
    
    func uiAction(selectionHandler: @escaping (T) -> Void) -> UIAction {
        let image = isSelected ? selectedItemImage : nil
        return UIAction(title: title, image: image) { _ in
            selectionHandler(id)
        }
    }
    
}

