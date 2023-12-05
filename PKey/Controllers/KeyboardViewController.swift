import UIKit
import SwiftUI
import simd

class KeyboardViewController: UIInputViewController, DynamicCalibrationDelegate {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    private var dynamicCalibration: DynamicCalibration?
    
    let keyboardKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNextKeyboardButton()
        setupDynamicCalibration()
        setupKeyboard()
    }
    
    private func setupNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: ""), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeListButton(_:)), for: .allTouchEvents)
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupDynamicCalibration() {
        dynamicCalibration = DynamicCalibration.create()
        dynamicCalibration?.delegate = self
    
    }
    
    private func setupKeyboard() {
        let keyRows = keyboardKeys.split(into: 10)
        let keyboardStackView = createKeyboardStackView()
        
        for row in keyRows {
            let rowStackView = createRowStackView()
            for character in row {
                let keyButton = createKeyButton(title: String(character))
                rowStackView.addArrangedSubview(keyButton)
            }
            keyboardStackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func createKeyboardStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        return stackView
    }
    
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.alignment = .center
        rowStackView.spacing = 10.0
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return rowStackView
    }
    
    private func createKeyButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc private func keyPressed(_ sender: UIButton) {
        guard let key = sender.currentTitle else { return }
        let proxy = textDocumentProxy
        proxy.insertText(key)
    }
    
    @objc private func handleInputModeList(from view: UIInputView?, with event: UIEvent) {
        // Implementation for switching input modes
    }
    
    // Correct method signature for handling input mode list
    @objc private func handleInputModeListButton(_ sender: UIButton) {
        // Implementation for handling the button action to switch input modes
        self.advanceToNextInputMode()
    }
    
    // DynamicCalibrationDelegate methods
    func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3) {
        // Handle the updated eye offset here
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // Handle text will change here
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // Handle text did change here
    }
}

extension String {
    func split(into length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map(String.init)
    }
}
