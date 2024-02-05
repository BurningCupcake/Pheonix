import UIKit
import ARKit
import SwiftUI

class EyeGazeViewController: UIViewController, EyeTrackerDelegate {
    private var gazeDetection: GazeDetection?
    private var eyeTracker: EyeTracker?
    private var keyboardInteraction: KeyboardInteraction?
    private var textEntryService: TextEntryService = TextEntryService()
    @State private var text: String = ""
    private var keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate EyeTracker directly since it doesn't require parameters
        let eyeTracker = EyeTracker()
        self.eyeTracker = eyeTracker  // Assign to the class property if needed elsewhere
        
        // Initialize DynamicCalibration with the EyeTracker instance
        let dynamicCalibration = DynamicCalibration(eyeTracker: eyeTracker)
        
        // Ensure DynamicCalibration conforms to GazeDetectionDelegate
        gazeDetection = GazeDetection(delegate: dynamicCalibration as! any GazeDetectionDelegate as GazeDetectionDelegate)

        
        // Continue with KeyboardInteraction initialization
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        // Create bindings
        let textBinding = Binding<String>(
            get: { self.text },
            set: { self.text = $0 }
        )
        let wordSuggestionsBinding = Binding<[String]>(
            get: { self.keyboardViewDelegateWrapper.wordSuggestions },
            set: { self.keyboardViewDelegateWrapper.wordSuggestions = $0 }
        )
        let spellingIndicatorBinding = Binding<Bool>(
            get: { self.keyboardViewDelegateWrapper.spellingIndicator },
            set: { self.keyboardViewDelegateWrapper.spellingIndicator = $0 }
        )
        
        // Create and setup the SwiftUI keyboard view
        let keyboardView = KeyboardView(
            delegateWrapper: keyboardViewDelegateWrapper,
            text: textBinding,
            wordSuggestions: wordSuggestionsBinding,
            spellingIndicator: spellingIndicatorBinding,
            keyboardLayout: KeyboardLayout.defaultLayout(),
            textEntryService: textEntryService
        )
        
        // Embed the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: keyboardView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Start gaze detection and eye tracking
        gazeDetection?.start()
        eyeTracker.startTracking()  // Directly call since eyeTracker is guaranteed to be non-nil here
    }
}
    // MARK: - GazeDetectionDelegate
    extension EyeGazeViewController: GazeDetectionDelegate {
        func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
            // Handle gaze point detection...
        }
        
        func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
            return view.window?.windowScene?.interfaceOrientation ?? .unknown
        }
}

