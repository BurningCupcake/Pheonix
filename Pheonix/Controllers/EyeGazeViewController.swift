import UIKit
import ARKit

class EyeGazeViewController: UIViewController {
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var wordSuggestion: WordSuggestion!
    private var eyeTrackingController: EyeTrackingController!
    private var keyboardView: KeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        eyeTrackingController = EyeTrackingController()
        
        gazeDetection.delegate = eyeTrackingController
        keyboardInteraction.delegate = self
        wordSuggestion.delegate = self
        
        keyboardView = KeyboardView()
        keyboardView.keyboardDelegate = self
        keyboardView.backgroundColor = UIColor.lightGray
        
        view.addSubview(keyboardView)
        
        gazeDetection.start()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        keyboardView.frame = view.bounds
    }
}

extension EyeGazeViewController: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }
}

extension EyeGazeViewController: KeyboardInteractionDelegate {
    func didSelectKey(_ key: String) {
        textEntry.keyboardInteraction(self, didSelectKey: key)
        wordSuggestion.processTextEntry(textEntry)
    }
}

extension EyeGazeViewController: WordSuggestionDelegate {
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        keyboardView.updateWordSuggestions(words)
    }
}
