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
        
        let keyboardView = KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout())
            .environmentObject(keyboardViewDelegateWrapper)
        
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
        
        gazeDetection.delegate = self
        eyeTracker.delegate = self
        
        gazeDetection.start()
        eyeTracker.startTracking()
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

extension EyeGazeViewController: WordSuggestionDelegate {
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        keyboardViewDelegateWrapper.wordSuggestions = words
    }
}

