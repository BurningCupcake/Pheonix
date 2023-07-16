import UIKit
import ARKit
import SwiftUI

class EyeGazeViewController: UIViewController {
    private var gazeDetection: GazeDetection!
    private var eyeTracker: EyeTracker!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntryService: TextEntryService!
    @EnvironmentObject private var keyboardViewDelegateWrapper: KeyboardViewDelegateWrapper
    private var textEntry: TextEntry = TextEntry()
    
    private var gazeDirection: SCNVector3 = SCNVector3Zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        let dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService) // Pass the textEntryService
        
        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(wordSuggestions: $keyboardViewDelegateWrapper.wordSuggestions, spellingIndicator: $keyboardViewDelegateWrapper.spellingIndicator, keyboardLayout: KeyboardLayout.defaultLayout())
            .environmentObject(keyboardViewDelegateWrapper) // Wrap with EnvironmentObject
        
        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: keyboardView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set up delegates and start gaze detection and eye tracking
        gazeDetection.delegate = self
        eyeTracker.delegate = self
        gazeDetection.start()
        eyeTracker.startTracking()
        
        // Track text entry updates
        textEntryService.trackTextEntryUpdates { [weak self] state in
            self?.textEntry = state.textEntry
        }
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

// Rest of the code remains the same
