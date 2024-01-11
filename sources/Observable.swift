class Observable<T> {
  var value: T? {
    didSet {
      _callback?(value)
    }
  }

  private var _callback: ((T) -> Void)?

  func bind(callback: @escaping (T?) -> Void) {
    _callback = callback
}

  // view model içi
  // var messageText: Observable<String> = Observable()

  viewModel.messageText.bind = { [weak self] value in
                                self?.messageLabel.text = value
                               }
    
