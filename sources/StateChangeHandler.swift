class ViewModel {
    enum Change {
        case retrivedMessage(value: String)
        case isLoading(value: Bool)
    }

    var stateChangeHandler: ((Change) -> Void)?

    private var message: String? {
        didSet {
            stateChangeHandler?(.retrivedMessage(value: message ?? ""))
        }
    }

    private var isLoading = false {
        didSet {
            stateChangeHandler?(.isLoading(value: isLoading))
        }
    }

    func loadData() {
        isLoading = true
        // servis istekleri vs.
        self.isLoading = false
        message = "Hello world!"
    }
}

class ViewController: UIViewController {
    private let viewModel = ViewModel()

    override func viewDidLoad() { 
        // other codes
        viewModel.stateChangeHandler = { change in
            switch change {
                case .retrivedMessage(value: let value):
                    self.retrivedLabel.text = value
                // ...
            }
        }
    }
}
