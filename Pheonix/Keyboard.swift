// **Keyboard.swift**

// In this file, we have the Keyboard class that inherits from UIInputViewController and conforms to the GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate, and SwipeToTypeControllerDelegate protocols.

//The Keyboard class represents the main view controller for the custom keyboard. Here are the key points:

//The class properties include various dependencies such as gazeDetection, keyboardInteraction, textEntryService, wordSuggestion, and more.
//In the viewDidLoad() method, the dependencies are instantiated, delegates are set, and the SwiftUI-based keyboard view is created and added as a subview.
//The gazeDetection(_:didDetectGazeAt:) method is called when a gaze is detected, and it forwards the gaze point to the keyboardInteraction for processing.
//The didSelectKey(_:) method is called when a key is selected, and it adds the selected character to the textEntryService using the addCharacter(_:) method. It handles the success or failure result and updates the word suggestions accordingly.
//The wordSuggestion(_:didSuggestWords:) method is called when word suggestions are provided by the wordSuggestion object, and it updates the word suggestions in the keyboard view.
//The didSwipeLeft() method is called when a swipe left event occurs. You can implement the desired action for swipe-to-type functionality in this method.

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

