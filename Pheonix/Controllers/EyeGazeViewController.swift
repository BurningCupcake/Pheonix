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
        
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        eyeTracker = EyeTracker()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        textEntryService = TextEntryService()
        wordSuggestion = WordSuggestion()
        keyboardViewDelegateWrapper = KeyboardViewDelegateWrapper()
        
        gazeDetection.delegate = self
        eyeTracker.delegate = self
        keyboardInteraction.delegate = self
        wordSuggestion.delegate = self
        
        let keyboardView = KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout())
            .environmentObject(keyboardViewDelegateWrapper)
        
        view.addSubview(keyboardView)
        
        gazeDetection.start()
        eyeTracker.startTracking()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Adjust the frame of the keyboard view
        // ...
    }
}

extension EyeGazeViewController: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }
}

extension EyeGazeViewController: EyeTrackerDelegate {
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        keyboardInteraction.processGazePoint(gazePoint)
    }
}

extension EyeGazeViewController: KeyboardInteractionDelegate {
    func didSelectKey(_ key: String) {
        textEntryService.addCharacter(key)
        wordSuggestion.processTextEntry(textEntryService)
    }
}

extension EyeGazeViewController: WordSuggestionDelegate {
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        keyboardViewDelegateWrapper.wordSuggestions = words
    }
}

