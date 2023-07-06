import UIKit
import SwiftUI
import Foundation


class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate {
    private var keyboardView: KeyboardView!
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var wordSuggestion: WordSuggestion!
    private var eyeTrackingController: EyeTrackingController!
    
    var keyboardView: KeyboardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create dependencies
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardView.defaultLayout)
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        eyeTrackingController = EyeTrackingController(eyeTracker: EyeTracker(), wordSuggestion: wordSuggestion)
        
        // Setup delegates
        gazeDetection.delegate = self
        dynamicCalibration.delegate = eyeTrackingController
        keyboardInteraction.delegate = self
        wordSuggestion.delegate = eyeTrackingController
        

        // Create the SwiftUI keyboard view
        let keyboardView = KeyboardView(keyboardInteraction: keyboardInteraction)
        self.keyboardView = keyboardView

        
        // Add the keyboard view to the input view
        view.addSubview(keyboardView)
        
        // Start gaze detection
        gazeDetection.start()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        keyboardView.frame = view.bounds
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
        // Handle key selection event
        // You can access the selected key here

   
    
    func updateWordSuggestions(_ suggestions: [String]) {
        keyboardView?.updateWordSuggestions(suggestions)
    }
}
