//This file represents a custom keyboard view controller. Here's a breakdown of its implementation:

//The class inherits from UIInputViewController, which is a base class for custom input view controllers in UIKit.
//It declares an outlet for the "Next Keyboard" button (nextKeyboardButton).
//The updateViewConstraints() method is overridden to add custom view sizing constraints. This method can be used to update the layout constraints of the view.
//The viewDidLoad() method is overridden to perform custom UI setup for the keyboard.
//In the viewDidLoad() method, the "Next Keyboard" button is created and configured. Its title is localized using NSLocalizedString. The button is added as a subview of the view controller's view, and layout constraints are set to position it.
//Keyboard keys are created and configured using the createKeyboardKey() helper method. Two keys ("A" and "B") are added to a horizontal UIStackView (keyboardStackView) that acts as a container for the keys. The stack view is added as a subview of the view controller's view, and layout constraints are set to position it.
//The viewWillLayoutSubviews() method is overridden to show or hide the "Next Keyboard" button based on whether the keyboard needs an input mode switch key.
//The textWillChange(_:) and textDidChange(_:) methods are overridden to perform any necessary actions when the document's contents are about to change or have changed.
//The keyPressed(_:) method is called when a keyboard key is pressed. It inserts the pressed key's title into the text input.
//The createKeyboardKey(title:) method is a helper method to create and configure a keyboard key button.

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
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
