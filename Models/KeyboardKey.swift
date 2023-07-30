// The import statement includes the UIKit framework, necessary for all iOS applications.
import UIKit

// This code defines a new class, `KeyboardKey`, that is a subclass of `UIView`. 
class KeyboardKey: UIView {
    
    // declaration and initialization of `gazeIndicator` variable as `UIView`.
    var gazeIndicator: UIView
    // declares a weak (non-owning) reference to a delegate object.
    weak var delegate: KeyboardViewDelegate?
    // Services for text entry are declared and initialized.
    let textEntryService: TextEntryService
    // The text checker object is declared and initialized.
    let textChecker: UITextChecker
    
    // Defines a static constant which is an array containing arrays with string elements, representing the default layout for the keyboard.
    static let defaultLayout = [
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
        ["K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"],
        ["U", "V", "W", "X", "Y", "Z", ".", ",", "?", "!"]
    ]
    
    // The initializer method for the class.
    init(textEntryService: TextEntryService, textChecker: UITextChecker) {
        self.textEntryService = textEntryService
        self.textChecker = textChecker
        // Initializes the red `gazeIndicator` UIView object.
        self.gazeIndicator = UIView()
        // The superclass initializer is called with a zero-sized rectangle, placing the `UIView` at the origin of its superview.
        super.init(frame: .zero)
        // Calls the methods to setup gaze indicator and keyboard layout.
        setupGazeIndicator()
        setupKeyboardLayout()
    }
    
    // Defines a requirement for subclasses to implement this initializer.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function sets up the gaze indicator, including its size, position, and corner radius
    func setupGazeIndicator() {
        // Code block to set up the gaze indicator.
        gazeIndicator.backgroundColor = UIColor.red
        gazeIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gazeIndicator)
        NSLayoutConstraint.activate([
            gazeIndicator.widthAnchor.constraint(equalToConstant: 20),
            gazeIndicator.heightAnchor.constraint(equalToConstant: 20),
            gazeIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            gazeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        gazeIndicator.layer.cornerRadius = 10
    }

    // The size of the keys on the keyboard is declared.
    let keySize = CGSize(width: 40, height: 40)
    
    // This function sets up the key labels and their attributes on the keyboard layout for each row and column.
    func setupKeyboardLayout() {
        var lastLabel: UILabel? = nil
        for (i, row) in KeyboardKey.defaultLayout.enumerated() {
            for (j, key) in row.enumerated() {
                let keyLabel = UILabel()
                keyLabel.text = key
                keyLabel.textAlignment = .center
                keyLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
                keyLabel.layer.cornerRadius = 8
                keyLabel.isUserInteractionEnabled = true
                keyLabel.translatesAutoresizingMaskIntoConstraints = false
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectKey(_:)))
                keyLabel.addGestureRecognizer(tapGesture)
                
                addSubview(keyLabel)
                // Auto Layout Constraints setting for positioning the keys.
                NSLayoutConstraint.activate([
                    keyLabel.widthAnchor.constraint(equalToConstant: keySize.width),
                    keyLabel.heightAnchor.constraint(equalToConstant: keySize.height),
                    keyLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(i) * keySize.height),
                    (lastLabel != nil ?  keyLabel.leftAnchor.constraint(equalTo: lastLabel!.rightAnchor) : keyLabel.leftAnchor.constraint(equalTo: leftAnchor)).priorityHigh()
                ])

                lastLabel = keyLabel
            }
        }
    }
    
    // Function that gets the text of the key that is selected.
    @objc func didSelectKey(_ sender: UITapGestureRecognizer) {
        if let keyLabel = sender.view as? UILabel, let key = keyLabel.text {
            delegate?.didSelectKey(key, textEntryService: textEntryService, textChecker: textChecker)
        }
    }
}
