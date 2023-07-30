// Import the necessary UIKit library.
import UIKit

// Define a custom class for a keyboard view controller, inheriting from UIInputViewController and conforming to the CalibrationDelegate protocol.
class KeyboardViewController: UIInputViewController, CalibrationDelegate {
    
    // Create definable variable `nextKeyboardButton` of type UIButton.
    // Create a private variable `dynamicCalibration` specifically for dynamic calibration functionality.
    // Define a constant string for keyboard keys.
    @IBOutlet var nextKeyboardButton: UIButton!
    private var dynamicCalibration: DynamicCalibration?
    let keyboardKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    // Override viewDidLoad to customize initial view conditions.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the properties of the next keyboard button.
        self.nextKeyboardButton = UIButton(type: .system)
        // Set title for the next keyboard button.
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        // Adjust button size to fit content.
        self.nextKeyboardButton.sizeToFit()
        // Set constraints property
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        // Define a method to run when the button is clicked.
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        // Add the button to the view.
        self.view.addSubview(self.nextKeyboardButton)

        // Constrain the next keyboard button to the left and bottom of the view.
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Create and delegate for dynamicCalibration object.
        dynamicCalibration = DynamicCalibration.create()
        dynamicCalibration?.delegate = self
        
        // Create, define properties of and add stack view to the view.
        let keyboardStackView = UIStackView()
        keyboardStackView.axis = .vertical
        keyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(keyboardStackView)
        keyboardStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        keyboardStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        // Split the keyboard keys into rows and define behavior for each row's keys.
        let keyRows = keyboardKeys.split(by: 10)
        
        // Loop over rows and create keyboard buttons from the keys.
        for row in keyRows {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .center
            rowStackView.spacing = 10.0
            rowStackView.translatesAutoresizingMaskIntoConstraints = false
            for key in row {
                let keyButton = createKeyboardKey(title: String(key))
                keyButton.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(keyButton)
            }
            keyboardStackView.addArrangedSubview(rowStackView)
        }
    }
    
    // Override viewWillLayoutSubviews to hide the next keyboard button when it is not needed.
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    // Override textWillChange to leave it empty as we're not doing anything when text will change.
    override func textWillChange(_ textInput: UITextInput?) {}
    
    // Override textDidChange to update the text color based on the keyboard's appearance.
    override func textDidChange(_ textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        textColor = proxy.keyboardAppearance == UIKeyboardAppearance.dark ? UIColor.white : UIColor.black
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    // Define the behavior when a key is pressed.
    @objc func keyPressed(_ sender: UIButton) {
        guard let keyTitle = sender.currentTitle else { return }
        let proxy = textDocumentProxy
        proxy.insertText(keyTitle)
    }
    
    // Empty function to manage input mode list.
    @objc func handleInputModeList(from view: UIInputView?, with event: UIEvent) {}
    
    // Create a keyboard key with a defined title.
    func createKeyboardKey(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // Define functions for calibration delegate protocol.
    func didStartCalibration() {}
    func didCompleteCalibration(withResult result: CalibrationResult) {}
    func didFailCalibration(withError error: Error) {}
}

// Extension of the Collection class to
