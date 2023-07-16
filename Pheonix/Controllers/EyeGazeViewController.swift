import UIKit
import ARKit
import SwiftUI

class EyeGazeViewController: UIViewController {
    private var gazeDetection: GazeDetection!
    private var eyeTracker: EyeTracker!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntryService: TextEntryService!
    private var keyboardViewDelegateWrapper: KeyboardViewDelegateWrapper!
    private var dynamicCalibration: DynamicCalibration!
    private var textChecker: UITextChecker  // Add UITextChecker instance
    
    private var gazeDirection: SCNVector3 = SCNVector3Zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        keyboardInteraction.delegate = self
        keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper()
        textChecker = UITextChecker()  // Initialize UITextChecker
        
        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout())
            .environmentObject(keyboardViewDelegateWrapper)
        
        // Embed the SwiftUI view in a UIHostingController
        if let keyboardContentView = UIHostingController(rootView: keyboardView).view {
            keyboardContentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(keyboardContentView)
            NSLayoutConstraint.activate([
                keyboardContentView.topAnchor.constraint(equalTo: view.topAnchor),
                keyboardContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                keyboardContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                keyboardContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        // Set up delegates and start gaze detection and eye tracking
        gazeDetection.delegate = self
        eyeTracker.delegate = self
        gazeDetection.start()
        eyeTracker.startTracking()
    }
}

// GazeDetectionDelegate extension
extension EyeGazeViewController: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        // Implement your gaze detection logic
        // You may update the gazeDirection property here based on your implementation
        
        // For example, calculate the gaze direction vector using point
        
        // Update the gazeDirection property
        gazeDirection = calculateGazeDirection(point: point)
    }
    
    private func calculateGazeDirection(point: CGPoint) -> SCNVector3 {
        // Implement your logic to calculate the gaze direction vector based on the gaze point
        // Convert the point to a ray or direction vector using appropriate calculations
        
        // Example implementation:
        let gazeDirection = SCNVector3(0, 0, -1) // Sample gaze direction pointing straight ahead
        return gazeDirection
    }
}

// EyeTrackerDelegate extension
extension EyeGazeViewController: EyeTrackerDelegate {
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        // Not used in this implementation
    }
}

// KeyboardInteractionDelegate extension
extension EyeGazeViewController: KeyboardInteractionDelegate {
    func didSelectKey(_ key: String) {
        // Use the gazeDirection to determine the selected key on the keyboard
        let selectedKey = determineSelectedKey(gazeDirection: gazeDirection)
        
        // Perform the key selection action
        let result = textEntryService.addCharacter(selectedKey)
        
        switch result {
            case .success(let state):
                print("New state: \(state)")
                let completions = textChecker.completions(forPartialWordRange: NSRange(location: 0, length: state.text.utf16.count),
                                                          in: state.text,
                                                          language: "en_US")
                let suggestions = completions ?? []
                keyboardViewDelegateWrapper.wordSuggestions = suggestions
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
    
    private func determineSelectedKey(gazeDirection: SCNVector3) -> String {
        // Implement your logic to determine the selected key based on the gazeDirection
        // Calculate the intersection point of the gazeDirection with the keyboard layout
        // Map the intersection point to the corresponding key on the keyboard
        
        // Example implementation:
        // ...
        
        return "A" // Return the selected key
    }
}
