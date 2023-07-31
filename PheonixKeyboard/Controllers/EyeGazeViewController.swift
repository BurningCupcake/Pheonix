import UIKit
import ARKit
import SwiftUI

// A view controller that handles gaze tracking and keyboard interactions
class EyeGazeViewController: UIViewController {
    // Gaze detection object that carries out gaze tracking
    private var gazeDetection: GazeDetection?
    // Eye tracker that tracks eye movements
    private var eyeTracker: EyeTracker?
    // Handles keyboard interactions
    private var keyboardInteraction: KeyboardInteraction?
    // Service for text entry
    private var textEntryService: TextEntryService?
    
    // Direction of gaze
    private var gazeDirection: SCNVector3 = SCNVector3Zero
    
    // Called once the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        let dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService!) 
        
        // Create a SwiftUI keyboard view
        let keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper()
        let keyboardView = KeyboardView(delegateWrapper: keyboardViewDelegateWrapper, wordSuggestions: keyboardViewDelegateWrapper.wordSuggestions, spellingIndicator: keyboardViewDelegateWrapper.spellingIndicator, keyboardLayout: KeyboardLayout.defaultLayout())
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
        gazeDetection?.delegate = self
        eyeTracker?.delegate = self
        gazeDetection?.start()
        eyeTracker?.startTracking()
    }
}

// MARK: - Extensions

// Conforming EyeGazeViewController to GazeDetectionDelegate protocol
extension EyeGazeViewController: GazeDetectionDelegate {

    // Returns the interface orientation of the view
    func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
        return view.window?.windowScene?.interfaceOrientation ?? .unknown
    }
}
