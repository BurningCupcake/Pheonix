import UIKit
import SwiftUI
import ARKit
import Combine

// Keyboard class implementing various delegate methods
class Keyboard: UIInputViewController {
    // Properties for different functionalities
    @State private var text: String = ""
    private var gazeDetection: GazeDetection?
    private var dynamicCalibration: DynamicCalibration?
    private var keyboardInteraction: KeyboardInteraction?
    private var textEntryService: TextEntryService = TextEntryService()
    private var eyeTracker: EyeTracker?
    private var swipeToTypeController: SwipeToTypeController?
    private var spellingIndicatorWrapper = SpellingIndicatorDelegateWrapper()
    private var eyeGazeViewController: EyeGazeViewController?
    
    // SwiftUI View for Keyboard
    private var keyboardView: KeyboardView?
    
    // Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupDelegates()
        setupKeyboardView()
        startServices()
    }
    
    // MARK: - Setup Methods
    private func setupComponents() {
        eyeTracker = EyeTracker()
        
        guard let eyeTracker = eyeTracker else {
            fatalError("EyeTracker could not be initialized")
        }
        
        // Initialize DynamicCalibration with the eyeTracker instance
        dynamicCalibration = DynamicCalibration(eyeTracker: eyeTracker)
        
        let eyeGazeViewController = EyeGazeViewController()
        
        // Initialize GazeDetection with dynamicCalibration as its delegate
        // Assuming dynamicCalibration conforms to GazeDetectionDelegate
        if let eyeGazeViewController = eyeGazeViewController {
            gazeDetection = GazeDetection(delegate: eyeGazeViewController)
        }
        
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        swipeToTypeController = SwipeToTypeController()
    }
    
    private func setupDelegates() {
        gazeDetection?.delegate = self
        keyboardInteraction?.delegate = self
        swipeToTypeController?.delegate = self
        eyeTracker?.delegate = self
        dynamicCalibration?.delegate = self
    }
    
    private func setupKeyboardView() {
        // Create bindings to the properties of spellingIndicatorWrapper
        let wordSuggestionsBinding = Binding<[String]>(
            get: { self.spellingIndicatorWrapper.wordSuggestions },
            set: { self.spellingIndicatorWrapper.wordSuggestions = $0 }
        )
        let spellingIndicatorBinding = Binding<Bool>(
            get: { self.spellingIndicatorWrapper.spellingIndicator },
            set: { self.spellingIndicatorWrapper.spellingIndicator = $0 }
        )
        
        // Initialize KeyboardView with the required bindings and textEntryService
        keyboardView = KeyboardView(
            delegateWrapper: KeyboardViewDelegateWrapper(),
            text: $text,
            wordSuggestions: wordSuggestionsBinding,
            spellingIndicator: spellingIndicatorBinding,
            keyboardLayout: KeyboardLayout.defaultLayout(),
            textEntryService: textEntryService  // Pass the textEntryService instance here
        )
        
        // Further code to add the view to the view hierarchy...
    }
    private func startServices() {
        gazeDetection?.start()
        eyeTracker?.startTracking()
    }
    
    // MARK: - Gaze Detection Handling
    private func processGazePoint(_ point: CGPoint) {
        keyboardInteraction?.processGazePoint(point)
    }
    
    // MARK: - Keyboard Interaction Handling
    private func handleKeySelection(_ key: String) {
        let result = textEntryService.addCharacter(key)
        
        switch result {
            case .success(let updatedState):
                // If addition of character was successful, update the UI
                // For example, update the text in the keyboard view
                self.keyboardView?.updateText(updatedState.text)
                
                // Optionally, you can also fetch and update word suggestions and spelling indicator
                // This depends on how you intend to use these features in your app
                updateWordSuggestionsAndSpellingIndicator(for: updatedState.text)
                
            case .failure(let error):
                // Handle the error case, such as showing an alert or a message
                // You might want to log the error or inform the user
                print("Error adding character: \(error)")
        }
    }
    
    // Helper method to update word suggestions and spelling indicator
    private func updateWordSuggestionsAndSpellingIndicator(for text: String) {
        // Assuming 'textEntryService' can provide word suggestions and spelling check
        let wordSuggestions = textEntryService.getWordCompletions(for: text)
        let isSpellingCorrect = textEntryService.performSpellChecking(for: text)
        
        // Update UI elements in the KeyboardView
        self.keyboardView?.updateWordSuggestions(wordSuggestions)
        self.keyboardView?.updateSpellingIndicator(isSpellingCorrect)
        
    }
}
    // MARK: - GazeDetectionDelegate
    extension Keyboard: GazeDetectionDelegate {
        func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
            processGazePoint(point)
        }
        
        func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
            return self.view.window?.windowScene?.interfaceOrientation ?? .unknown
        }
    }
    
extension KeyboardViewController: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        // Process gaze point...
    }
    
    func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
        // Correctly access the interface orientation from the view controller context
        return self.view.window?.windowScene?.interfaceOrientation ?? .unknown
    }
}

    // MARK: - KeyboardInteractionDelegate
    extension Keyboard: KeyboardInteractionDelegate {
        func didSelectKey(_ key: String, textEntryService: TextEntryService) {
            handleKeySelection(key)
        }
    }

    // MARK: - SwipeToTypeControllerDelegate
    extension Keyboard: SwipeToTypeControllerDelegate {
        func didSwipe(in direction: UISwipeGestureRecognizer.Direction) {
            // Process swipe direction...
        }
    }
    
    // MARK: - EyeTrackerDelegate
    extension Keyboard: EyeTrackerDelegate {
        func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
            // Process gaze point...
        }
    }
    
    // MARK: - DynamicCalibrationDelegate
    extension Keyboard: DynamicCalibrationDelegate {
        func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3) {
            // Update eye offset...
            // Implementation as before
        }
        
        func didStartCalibration() {
            // Handle the start of calibration, e.g., showing a UI element or starting related processes
            print("Calibration has started")
            // Optionally, show the calibration view or make other UI adjustments
        }
        
        func didCompleteCalibration(withResult result: CalibrationResult) {
            // Handle the completion of calibration, e.g., updating the system with the new calibration result
            print("Calibration completed successfully with result: \(result)")
            // Optionally, apply the calibration result to your system
        }
        
        func didFailCalibration(withError error: Error) {
            // Handle a failure in the calibration process, e.g., showing an error message to the user
            print("Calibration failed with error: \(error)")
            // Optionally, inform the user of the failure and suggest retrying or provide help
        }
    }
    
    // MARK: - TextEntryDelegate and SpellingIndicatorDelegate
    extension Keyboard: TextEntryDelegate {
        func textEntry(_ textEntry: TextEntry, didUpdateText text: String) {
            // Handle the updated text here
            // For example, update a UI component that displays the text
            self.keyboardView?.updateText(text)
        }
    }
    
    extension Keyboard: SpellingIndicatorDelegate {
        func didUpdateWordSuggestions(_ suggestions: [String]) {
            // Handle the updated word suggestions here
            // For example, update a UI component that displays word suggestions
            self.keyboardView?.updateWordSuggestions(suggestions)
        }
        
        func didUpdateSpellingIndicator(_ isCorrect: Bool) {
            // Handle the updated spelling indicator here
            // For example, change the color of the text or show a notification
            self.keyboardView?.updateSpellingIndicator(isCorrect)
        }
    }

