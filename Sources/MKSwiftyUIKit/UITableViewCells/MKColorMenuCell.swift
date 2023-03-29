import UIKit

@available(iOS 15, *)
public struct MKColorMenuCellViewModel: Equatable {
    public var color = UIColor.gray
    public var menuItems: [MKColorMenuCell.MenuItem] = []
    public var contentConfiguration = UIListContentConfiguration.cell()
    public var isEnabled = true
    public mutating func selectClosestColor(to color: UIColor) {
        self.color = menuItems.closestColor(to: color)
    }
    public init() { }
}

@available(iOS 15, *)
open class MKColorMenuCell : MKFormCell {
    
    public struct MenuItem: Equatable {
        public let name: String
        public let color: UIColor
        public init(name: String, color: UIColor) {
            self.name = name
            self.color = color
        }
    }

    open var menuButton = UIButton(configuration: .plain())
    open var selectionHandler: ((UIColor) -> Void)?
    open var menuItems = [MenuItem]() {
        didSet {
            updateMenu()
        }
    }
    open var selectedColor: UIColor = .gray {
        didSet {
            updateMenu()
        }
    }
    
    open func selectClosestMenuColor(to color: UIColor) {
        selectedColor = menuItems.closestColor(to: color)
    }

    open func refresh(viewModel: MKColorMenuCellViewModel) {
        self.selectedColor = viewModel.color
        menuItems = viewModel.menuItems
        contentConfiguration = viewModel.contentConfiguration
        isUserInteractionEnabled = viewModel.isEnabled
        menuButton.isEnabled = viewModel.isEnabled
    }
    
    
    open override func setup() {
        selectionStyle = .none
        configureMenuButton()
    }

    private func configureMenuButton() {
        menuButton.configuration?.image = .init(systemName: "circle.fill")
        selectionStyle = .none
        accessoryView = menuButton
        menuButton.showsMenuAsPrimaryAction = true
        accessoryLayout.width = .fixed(27)
    }
    
    open override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        updateMenu()
    }
    
    private func updateMenu() {
        menuButton.configuration?.baseForegroundColor = selectedColor
        let menuActions = menuItems.map { menuItem in
            menuItem.menuAction { [weak self] color in
                self?.selectedColor = color
                guard let self else { return }
                self.selectionHandler?(color)
            }
        }
        menuButton.menu = .init(title: "Color", children: menuActions)
    }
}

@available(iOS 15, *)
public extension MKColorMenuCell.MenuItem {
    static let systemGray = Self(name: "Gray", color: .systemGray)
    static let systemRed = Self(name: "Red", color: .systemRed)
    static let systemPink = Self(name: "Pink", color: .systemPink)
    static let systemOrange = Self(name: "Orange", color: .systemOrange)
    static let systemBrown = Self(name: "Brown", color: .systemBrown)
    static let systemYellow = Self(name: "Yellow", color: .systemYellow)
    static let systemGreen = Self(name: "Green", color: .systemGreen)
    static let systemMint = Self(name: "Mint", color: .systemMint)
    static let systemTeal = Self(name: "Teal", color: .systemTeal)
    static let systemBlue = Self(name: "Blue", color: .systemBlue)
    static let systemCyan = Self(name: "Cyan", color: .systemCyan)
    static let systemIndigo = Self(name: "Indigo", color: .systemIndigo)
    static let systemPurple = Self(name: "Purple", color: .systemPurple)
}

@available(iOS 15, *)
public extension Array where Element == MKColorMenuCell.MenuItem {
    static func systemRainbow() -> [Element] {[
        .systemGray,
        .systemRed,
        .systemPink,
        .systemOrange,
        .systemBrown,
        .systemYellow,
        .systemGreen,
        .systemMint,
        .systemTeal,
        .systemBlue,
        .systemCyan,
        .systemIndigo,
        .systemPurple
    ]}
    
    func closestColor(to color: UIColor) -> UIColor {
        let index = self.map { $0.color }.firstIndex(closestTo: color)
        guard index < self.count else { return color }
        return self[index].color
    }
}

@available(iOS 15, *)
fileprivate extension MKColorMenuCell.MenuItem {
    
    func menuAction(handler: ((UIColor) -> ())?) -> UIAction {
        let image = UIImage(systemName: "circle.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(color)
        return .init(title: name, image: image) { action in
            handler?(color)
        }
    }
}

