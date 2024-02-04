import UIKit
import SwiftUI
import simd

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    // Assuming DynamicCalibrationModel exists and is correctly set up
    private var dynamicCalibration: DynamicCalibrationModel?
    private var fractalHostingController: UIHostingController<FractalView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNextKeyboardButton()
        setupDynamicCalibration()
        setupKeyboard()
        setupFractalView()
    }
    
    private func setupNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: ""), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeListButton(_:)), for: .allTouchEvents)
        self.view.addSubview(self.nextKeyboardButton)
        
        NSLayoutConstraint.activate([
            self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupDynamicCalibration() {
        // Assuming DynamicCalibrationModel has been correctly set up to initialize with necessary components.
        dynamicCalibration = DynamicCalibrationModel()
    }
    
    private func setupKeyboard() {
        // Setup your keyboard layout here
        // This example does not detail keyboard layout setup due to its focus on calibration
    }
    
    private func setupFractalView() {
        // Assume DynamicCalibrationModel provides observable properties for scale and offset
        let fractalView = FractalView(scale: $dynamicCalibration.scale, offset: $dynamicCalibration.offset)
        fractalHostingController = UIHostingController(rootView: fractalView)
        
        guard let fractalViewHost = fractalHostingController else { return }
        
        addChild(fractalViewHost)
        view.addSubview(fractalViewHost.view)
        fractalViewHost.didMove(toParent: self)
        
        fractalViewHost.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fractalViewHost.view.topAnchor.constraint(equalTo: view.topAnchor),
            fractalViewHost.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fractalViewHost.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fractalViewHost.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        fractalViewHost.view.isHidden = true
    }
    
    func startCalibration() {
        fractalHostingController?.view.isHidden = false
        dynamicCalibration?.startCalibration()
    }
    
    func stopCalibration() {
        fractalHostingController?.view.isHidden = true
        dynamicCalibration?.stopCalibration()
    }
    }
    
    // DynamicCalibrationDelegate methods
    func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3) {
        // Handle the updated eye offset here, if applicable
    }
    
    @objc private func handleInputModeListButton(_ sender: UIButton) {
        self.advanceToNextInputMode()
    }
    
    // Add other utility methods as necessary for your keyboard layout and functionality
}

    
    // MARK: - Utility Methods
    
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
