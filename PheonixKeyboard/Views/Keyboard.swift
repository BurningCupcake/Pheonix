// Required frameworks
import Foundation
import SwiftUI
import ARKit

// Keyboard class implementing various delegate methods
class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, SwipeToTypeControllerDelegate, TextEntryDelegate, EyeTrackerDelegate, DynamicCalibrationDelegate, KeyboardViewDelegate, SpellingIndicatorDelegate {
    
    // Class properties
    private var keyboardHostingController: UIHostingController<KeyboardView>?
    private var gazeDetection: GazeDetection?
    private var dynamicCalibration: DynamicCalibration?
    private var keyboardInteraction: KeyboardInteraction?
    private var textEntry: TextEntry?
    private var eyeTracker: EyeTracker?
    private var swipeToTypeController: SwipeToTypeController?
    private let textEntryService = TextEntryService()
    private var keyboardView: KeyboardView?
    @ObservedObject private var spellingIndicatorWrapper = SpellingIndicatorDelegateWrapper()
    internal var currentInterfaceOrientation: UIInterfaceOrientation = .portrait
    private let textChecker = UITextChecker()
    
    // This function is called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the private class properties
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        textEntry = TextEntry()
        eyeTracker = EyeTracker()
        swipeToTypeController = SwipeToTypeController()
        
        // Set delegate properties
        gazeDetection?.delegate = self
        keyboardInteraction?.delegate = self
        swipeToTypeController?.delegate = self
        
        // Create keyboard view
        let delegateWrapper = KeyboardViewDelegateWrapper(spellingIndicator: spellingIndicatorWrapper.spellingIndicator)
        let keyboardView = KeyboardView(delegateWrapper: delegateWrapper, wordSuggestions: $spellingIndicatorWrapper.wordSuggestions, spellingIndicator: $spellingIndicatorWrapper.spellingIndicator, keyboardLayout: KeyboardLayout.defaultLayout())
        self.keyboardView = keyboardView
        
        // Create HostingContainer and add constraints
        keyboardHostingController = UIHostingController(rootView: keyboardView)
        keyboardHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(keyboardHostingController)
        view.addSubview(keyboardHostingController.view)
        keyboardHostingController.didMove(toParent: self)
        
        // If HostingContainer contains a child, attach to it
        if let keyboardContentView = keyboardHostingController?.view.subviews.first {
            swipeToTypeController?.attach(to: keyboardContentView)
        } else {
            // handle the case when the the first subview of keyboardHostingController is not available
        }
        
        // Start gaze detection and eye tracking
        gazeDetection?.start()
        eyeTracker?.startTracking()
    }
    
    // Called prior to the rotation of the interface
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.currentInterfaceOrientation = self.view.window?.windowScene?.interfaceOrientation ?? .unknown
        })
    }
}
    // GazeDetectionDelegate
// This protocol is a callback interface for gaze points detected by a gaze detector.
func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
    // Processes the gaze point on the keyboard.
    keyboardInteraction.processGazePoint(point)
}

// Detects the current orientation of the interface.
func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
    return self.currentInterfaceOrientation
}

// KeyboardInteractionDelegate
// This protocol is a callback interface for keys selected on a keyboard.
func didSelectKey(_ key: String) {
    //  Adds the selected key to the text entry service.
    let result = textEntryService.addCharacter(key)
    
    // Branches executed depends on whether key addition was successful or a failure.
    switch result {
    case .success(let state):
        // On success, gets word suggestions based on the current state of the keyboard.
        let completions = getWordCompletions(for: state.text)
        
        // Then, asynchronously updates spelling indicator and word suggestions.
        DispatchQueue.main.async {
            self.spellingIndicatorWrapper.updateWordSuggestions(completions)
        }
        let isSpellingCorrect = performSpellChecking(for: state.text)
        DispatchQueue.main.async {
            self.spellingIndicatorWrapper.spellingIndicator = isSpellingCorrect
        }
    case .failure(let error):
        // On failure, prints the error.
        print("Error adding character: \(error)")
    }
}

// These are helper functions for KeyboardInteractionDelegate.
private func getWordCompletions(for text: String) -> [String] {
    // Gets potential completions for a string of characters.
    let range = NSRange(text.startIndex..<text.endIndex, in: text)
    let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
    
    // If no completions are found, returns an empty array.
    return completions ?? []
}

private func performSpellChecking(for text: String) -> Bool {
    // Checks if the string of characters is spelled correctly.
    let range = NSRange(text.startIndex..<text.endIndex, in: text)
    let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US") 
    
    // Returns true if there is no misspelled word - determined by NSNotFound situation.
    return misspelledRange.location == NSNotFound
}

// SwipeToTypeControllerDelegate
// This protocol is a callback interface for swipe direction made by a user.
func swipeToTypeController(_ swipeToTypeController: SwipeToTypeController, didSwipeInDirection direction: SwipeDirection) {
    // Processes the swipe direction on the keyboard.
    keyboardInteraction.processSwipeInDirection(direction)
}

// TextEntryDelegate
// This protocol is a callback interface for updates to the text entry field. 
func textEntry(_ textEntry: TextEntry, didUpdateText text: String) {
    // Updates the text shown on the keyboard.
    keyboardView.text = text
}

// EyeTrackerDelegate
// This protocol is a callback interface for gaze updates from an eye tracker.
func eyeTracker(_ eyeTracker: EyeTracker, didUpdateGaze gaze: ARRaycastResult) {
    // Processes the received gaze.
    gazeDetection.processGaze(gaze)
}

// DynamicCalibrationDelegate
// This protocol is a callback interface for eye offset updates made by dynamic calibration.
func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3) {
    // Updates the eye offset in gaze detection.
    gazeDetection.updateEyeOffset(eyeOffset)
}

// KeyboardViewDelegate
// This protocol is a callback interface for key taps on a keyboard.
func didTapOnKey(_ key: String) {
    // Processes the key tapped on the keyboard.
    self.keyboardInteraction.processKeyTap(key)
}

// SpellingIndicatorDelegate
// This protocol is a callback interface for updates made to spelling indicator. 
func didUpdateSpellingIndicator(_ isSpellingCorrect: Bool) {
    // Updates spelling indicator on the keyboard.
    self.keyboardView.updateSpellingIndicator(isSpellingCorrect)
}

// This protocol is a callback interface for updates made to word suggestions.
func didUpdateSuggestions(_ wordSuggestions: [String]) {
    // Updates word suggestions on the keyboard.
    self.keyboardView.updateWordSuggestions(wordSuggestions)
}

