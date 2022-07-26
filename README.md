# MKSwiftyUIKit

A collection of convenience functions to speed up the development of UIKit based applications. 
Using these simple helpers can easily reduce the size of a UIKit codebase by more than 50% line of code. 

Consider the following typical example of a UIView containing a single label.

Using standard UIKit methods: 24 lines of code.


```
class MyView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
        label.text = "Hello World"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .green
        label.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
} 
```

Using MKSwiftyUIKit: 9 lines of code.

```
class MySwiftyView: MKSwiftySetupUIView {
    
    let label = UILabel(text: "Hello World", alignment: .center, textColor: .green, font: .preferredFont(forTextStyle: .headline))
    
    override func setup() {
        addSubview(label)
        label.constrainToLayoutGuide(layoutMarginsGuide)
    }
    
}

```
