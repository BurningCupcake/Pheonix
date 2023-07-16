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
    
    internal var textEntry: TextEntry!
    
    private var gazeDirection: SCNVector3 = SCNVector3Zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService) // Pass the textEntryService
        keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper()
        
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
        
        // Subscribe to the latest text entry state
        textEntryService.subscribeToLatestTextEntryState()
    }
}

// MARK: - Extensions

// GazeDetectionDelegate extension
extension EyeGazeViewController: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }
}

// EyeTrackerDelegate extension
extension EyeGazeViewController: EyeTrackerDelegate {
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        keyboardInteraction.processGazePoint(gazePoint)
    }
}

// KeyboardInteractionDelegate extension
extension EyeGazeViewController: KeyboardInteractionDelegate {
    func didSelectKey(_ key: String) {
        let result = textEntryService.addCharacter(key)
        switch result {
            case .success(let state):
                print("New state: \(state)")
                let wordSuggestionInstance = WordSuggestion() // Replace with your existing WordSuggestion class instance
                let currentText = textEntry.currentText // Retrieve the current text
                wordSuggestionInstance.processTextEntry(textEntryService, currentText: currentText)
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
}

// WordSuggestionDelegate extension
extension EyeGazeViewController: WordSuggestionDelegate {
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        keyboardViewDelegateWrapper.wordSuggestions = words
    }
}
