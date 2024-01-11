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

class ViewModel {
  var messageText: Observable<String> = Observable()
}

class ViewController: UIViewController {
    viewModel.messageText.bind = { [weak self] value in
                              self?.messageLabel.text = value
                             }
}


    
