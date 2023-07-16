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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        keyboardInteraction.delegate = self
        keyboardInteraction.textEntryService = textEntryService
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
                let completions = textChecker.completions(forPartialWordRange: NSRange(location: 0, length: state.text.utf16.count),
                                                          in: state.text,
                                                          language: "en_US")
                let suggestions = completions ?? []
                keyboardViewDelegateWrapper.wordSuggestions = suggestions
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
}
