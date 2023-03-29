import UIKit


@available(iOS 15, *)
public struct MKPopupMenuCellViewModel<T: Equatable>: Equatable {
    public var menu = MKPopupMenuCell<T>.Menu()
    public var contentConfuguration = UIListContentConfiguration.cell()
    public var buttonConfiguration: UIButton.Configuration = .popupMenuCell()
    public var isEnabled = true
    public init() { }
}

@available(iOS 15, *)
public extension UIButton.Configuration {
    static func popupMenuCell() -> Self {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 5
        config.image = .init(systemName: "chevron.up.chevron.down")
        return config
    }
}

@available(iOS 15, *)
open class MKPopupMenuCell<T: Equatable>: MKFormCell {
    
    public struct Menu: Equatable {
        public var title: String = ""
        public var items = [MenuItem]()
        public init() { }
    }
    
    public struct MenuItem: Equatable {
        public let id: T
        public var text: String
        public var isSelected: Bool
        public init(id: T, text: String, isSelected: Bool) {
            self.id = id
            self.text = text
            self.isSelected = isSelected
        }
    }
    
    open var menuButton = UIButton(configuration: .plain())
    open var selectionHandler: ((T) -> Void)?
    open var menu = Menu() {
        didSet {
            updateMenu()
        }
    }
    
    open func refresh(viewModel: MKPopupMenuCellViewModel<T>) {
        menu = viewModel.menu
        contentConfiguration = viewModel.contentConfuguration
        menuButton.configuration = viewModel.buttonConfiguration
        isUserInteractionEnabled = viewModel.isEnabled
        menuButton.isEnabled = viewModel.isEnabled
    }
    
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
        menuButton.configuration = .popupMenuCell()
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    open override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        updateMenu()
    }
    
    private func updateMenu() {
        let actions = menu.items.map { item in
            item.uiAction {[weak self] id in
                guard let self else { return }
                self.selectionHandler?(item.id)
            }
        }
        menuButton.menu = UIMenu(title: menu.title, children: actions)
    }

}

@available(iOS 15, *)
public extension MKPopupMenuCellViewModel where T : BinaryInteger, T : Comparable, T : Strideable, T.Stride == Int {
    static func numberPicker(range: ClosedRange<T>, selected: T) -> MKPopupMenuCellViewModel<T> {
        guard range.contains(selected) else {
            fatalError("index \(selected) out of bounds: range=\(range)")
        }
        var viewModel = MKPopupMenuCellViewModel<T>()
        viewModel.menu.items = range.map { value in
            .init(id: value, text: "\(value)", isSelected: value == selected)
        }
        viewModel.buttonConfiguration.title = "\(selected)"
        return viewModel
    }
}



@available(iOS 15, *)
fileprivate extension  MKPopupMenuCell.MenuItem {
    
    var selectedItemImage: UIImage? {
        UIImage(systemName: "checkmark")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.blue)
    }
    
    func uiAction(selectionHandler: @escaping (T) -> Void) -> UIAction {
        let image = isSelected ? selectedItemImage : nil
        return UIAction(title: text, image: image) { _ in
            selectionHandler(id)
        }
    }
    
}
