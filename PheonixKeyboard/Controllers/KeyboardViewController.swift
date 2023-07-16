
import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    private let dynamicCalibration = DynamicCalibration.create()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Start the calibration process when the keyboard view loads
        dynamicCalibration.performCalibration(in: self) { success in
            if success {
                // Calibration succeeded, update the keyboard UI or behavior as needed
            } else {
                // Calibration failed, handle the error as needed
            }
        }
        
        
        // Create and configure keyboard keys
        let key1 = createKeyboardKey(title: "A")
        key1.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        let key2 = createKeyboardKey(title: "B")
        key2.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        // Add more keys as needed
        
        // Add keyboard keys to the view
        let keyboardStackView = UIStackView(arrangedSubviews: [key1, key2])
        keyboardStackView.axis = .horizontal
        keyboardStackView.spacing = 10.0
        keyboardStackView.alignment = .center
        keyboardStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(keyboardStackView)
        
        // Position the keyboard keys using constraints
        keyboardStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        keyboardStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    // MARK: - Keyboard Key Actions
    
    @objc func keyPressed(_ sender: UIButton) {
        guard let keyTitle = sender.currentTitle else {
            return
        }
        
        // Insert the pressed key's title into the text input
        let proxy = textDocumentProxy
        proxy.insertText(keyTitle)
    }
    
    // MARK: - Helper methods
    
    func createKeyboardKey(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
