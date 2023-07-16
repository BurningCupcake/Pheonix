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
    private var textChecker: UITextChecker = UITextChecker()  // Initialize UITextChecker with an initial value
    
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
        keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper(textEntryService: textEntryService, textChecker: textChecker) // Pass the textEntryService and textChecker instances
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

// Rest of the code remains the same
