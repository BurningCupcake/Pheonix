import Foundation
import SwiftUI

class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate, SwipeToTypeControllerDelegate {
    
    private var keyboardHostingController: UIHostingController<KeyboardView>!
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var wordSuggestion: WordSuggestion!
    private var eyeTrackingController: EyeTrackingController!
    private var swipeToTypeController: SwipeToTypeController!
    private let textEntryService = TextEntryService()
    private var keyboardView: KeyboardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        eyeTrackingController = EyeTrackingController(eyeTracker: EyeTracker(), wordSuggestion: wordSuggestion)
        swipeToTypeController = SwipeToTypeController()
        
        // Setup delegates
        gazeDetection.delegate = self
        keyboardInteraction.delegate = self
        wordSuggestion.delegate = self
        swipeToTypeController.delegate = self
        
        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout())
        
        self.keyboardView = keyboardView
        
        // Create a hosting controller to integrate SwiftUI view with UIKit
        keyboardHostingController = UIHostingController(rootView: keyboardView)
        keyboardHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller's view to the input view
        addChild(keyboardHostingController)
        view.addSubview(keyboardHostingController.view)
        keyboardHostingController.didMove(toParent: self)
        
        // Attach swipe gesture recognizer to the keyboard view
        if let keyboardContentView = keyboardHostingController.view.subviews.first?.subviews.first {
            swipeToTypeController.attach(to: keyboardContentView)
        }
        
        // Start gaze detection
        gazeDetection.start()
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
                wordSuggestion.processTextEntry(textEntryService)
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
    
    // MARK: - WordSuggestionDelegate
    
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String]) {
        keyboardView?.updateWordSuggestions(suggestedWords)
    }
    
    // MARK: - SwipeToTypeControllerDelegate
    
    func didSwipeLeft() {
        // Handle the swipe left event
        // You can perform the swipe-to-type action here
    }
}

