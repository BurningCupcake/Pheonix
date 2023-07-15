//EyeGazeViewController.swift:
//- The EyeGazeViewController class is a UIViewController subclass responsible for managing the eye gaze tracking and keyboard interaction.
//- It adopts the GazeDetectionDelegate, EyeTrackerDelegate, and KeyboardInteractionDelegate protocols to handle the corresponding events.
//- It has references to various components such as gazeDetection, eyeTracker, textEntryService, wordSuggestion, and keyboardViewDelegateWrapper.
//- In the viewDidLoad() method, the necessary dependencies are initialized, the SwiftUI keyboard view is created and embedded in a UIHostingController, and gaze detection and eye tracking are started.
//- The class also includes extensions for the delegate methods to handle gaze detection, eye tracking, keyboard interaction, and word suggestions.



import UIKit
import ARKit
import SwiftUI

class EyeGazeViewController: UIViewController {
    private var gazeDetection: GazeDetection!
    private var eyeTracker: EyeTracker!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntryService: TextEntryService!
    private var wordSuggestion: WordSuggestion!
    private var keyboardViewDelegateWrapper: KeyboardViewDelegateWrapper!
    private var dynamicCalibration: DynamicCalibration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        textEntryService = TextEntryService()
        wordSuggestion = WordSuggestion()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        keyboardInteraction.delegate = self
        keyboardInteraction.textEntryService = textEntryService
        wordSuggestion.delegate = self
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
                wordSuggestion.processTextEntry(textEntryService)
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

