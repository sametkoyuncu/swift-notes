extension NSLayoutConstraint {
    static func activate(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach { $0.isActive = true }
    }

    static func pin(_ view: UIView, toEdgesOf otherView: UIView, withInset inset: UIEdgeInsets = .zero) {
        let constraints = [
            view.topAnchor.constraint(equalTo: otherView.topAnchor, constant: inset.top),
            view.leadingAnchor.constraint(equalTo: otherView.leadingAnchor, constant: inset.left),
            view.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: -inset.bottom),
            view.trailingAnchor.constraint(equalTo: otherView.trailingAnchor, constant: -inset.right)
        ]
        activate(constraints)
    }
}

// Usage
// NSLayoutConstraint.pin(myView, toEdgesOf: superview, withInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
