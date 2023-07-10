import UIKit
import SwiftUI
import Foundation

class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate, KeyboardViewDelegate {
    private var keyboardHostingController: UIHostingController<KeyboardView>!
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var wordSuggestion: WordSuggestion!
    private var eyeTrackingController: EyeTrackingController!
    private let textEntryService = TextEntryService()
    private var keyboardView: KeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        eyeTrackingController = EyeTrackingController()
        
        // Setup delegates
        gazeDetection.delegate = self
        keyboardInteraction.delegate = self
        wordSuggestion.delegate = self
        keyboardView.delegate = self
        
        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(keyboardInteraction: keyboardInteraction)
        self.keyboardView = keyboardView
        
        // Create a hosting controller to integrate SwiftUI view with UIKit
        keyboardHostingController = UIHostingController(rootView: keyboardView)
        keyboardHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller's view to the input view
        addChild(keyboardHostingController)
        view.addSubview(keyboardHostingController.view)
        keyboardHostingController.didMove(toParent: self)
        
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
    
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String) {
        textEntry.appendText(key)
        wordSuggestion.processTextEntry(textEntry)
    }
    
    // MARK: - WordSuggestionDelegate
    
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String]) {
        keyboardView?.updateWordSuggestions(suggestedWords)
    }
    
    // MARK: - KeyboardViewDelegate
    
    func didSelectKey(_ key: String) {
        // Handle the selection of a key when the user blinks while gazing at it
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            // If the key is a letter, add the letter to the text entry state
            textEntry.appendText(key)
            wordSuggestion.processTextEntry(textEntry)
        } else if key == " " {
            // If the key is a space, add a space to the text entry state
            textEntry.appendText(" ")
            wordSuggestion.processTextEntry(textEntry)
        } else if key == "<" {
            // If the key is a delete key, delete the last character from the text entry state
            textEntry.deleteLastCharacter()
            wordSuggestion.processTextEntry(textEntry)
        }
        // Add other cases as necessary
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        keyboardView?.updateWordSuggestions(suggestions)
    }
}
