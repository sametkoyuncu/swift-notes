# Programmatic UI

> [Source Code]()

### Create Component

```swift
private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
```

```swift
 private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds  = true
        return button
    }()
```

### Add component to View

```swift
override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        // coming soon :)
        configureConstraints()
    }
```

### Configure Constraints

> leading: left
> trailing: right

```swift
private func configureConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]

        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
```

### Screenshot

![programmatic-ui-ss]()
