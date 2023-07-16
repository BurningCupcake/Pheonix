import Foundation
import SwiftUI
import ARKit

class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, SwipeToTypeControllerDelegate {
    
    private var keyboardHostingController: UIHostingController<KeyboardView>!
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var eyeTracker: EyeTracker!
    private var swipeToTypeController: SwipeToTypeController!
    private let textEntryService = TextEntryService()
    private var keyboardView: KeyboardView!
    @ObservedObject private var spellingIndicatorWrapper = SpellingIndicatorDelegateWrapper()
    
    private let textChecker = UITextChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        textEntry = TextEntry()
        eyeTracker = EyeTracker()
        swipeToTypeController = SwipeToTypeController()
        
        // Setup delegates
        gazeDetection.delegate = self
        keyboardInteraction.delegate = self
        swipeToTypeController.delegate = self
        
        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout(), wordSuggestions: $spellingIndicatorWrapper.wordSuggestions, spellingIndicator: $spellingIndicatorWrapper.spellingIndicator)
        self.keyboardView = keyboardView
        
        // Create a hosting controller to integrate SwiftUI view with UIKit
        keyboardHostingController = UIHostingController(rootView: keyboardView.environmentObject(spellingIndicatorWrapper))
        keyboardHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller's view to the input view
        addChild(keyboardHostingController)
        view.addSubview(keyboardHostingController.view)
        keyboardHostingController.didMove(toParent: self)
        
        // Attach swipe gesture recognizer to the keyboard view
        if let keyboardContentView = keyboardHostingController.view.subviews.first {
            swipeToTypeController.attach(to: keyboardContentView)
        }
        
        // Start gaze detection
        gazeDetection.start()
        
        // Start eye tracking
        eyeTracker.startTracking()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        keyboardHostingController.view.frame = view.bounds
    }
    
    // MARK: - GazeDetectionDelegate
    
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }
    
    // MARK: - KeyboardInteractionDelegate
    
    func didSelectKey(_ key: String) {
        let result = textEntryService.addCharacter(key)
        switch result {
            case .success(let state):
                print("New state: \(state)")
                
                let completions = getWordCompletions(for: state.text)
                DispatchQueue.main.async { [self] in
                    self.spellingIndicatorWrapper.wordSuggestions = completions
                }
                
                // Perform spell checking
                let isSpellingCorrect = performSpellChecking(for: state.text)
                DispatchQueue.main.async { [self] in
                    self.spellingIndicatorWrapper.spellingIndicator = isSpellingCorrect
                }
                
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
    
    // MARK: - Word Completions
    
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    // MARK: - Spell Checking
    
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - SwipeToTypeControllerDelegate
    
    func didSwipeLeft() {
        // Handle the swipe left event
        // You can perform the swipe-to-type action here
    }
}
