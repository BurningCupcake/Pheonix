import UIKit

class DependencyInjection {
    static let shared = DependencyInjection()
    
    // Declare all the dependencies here
    var keyboardInteraction: KeyboardInteraction?
    var eyeTrackingController: EyeTrackingController?
    var gazeDetection: GazeDetection?
    var textEntry: TextEntry?
    var settings: Settings?
    var wordSuggestion: WordSuggestion?
    var eyeTracker: EyeTracker?
    
    // The private initializer to make sure it remains a singleton
    private init() {}
    
    // Functions to provide dependencies
    func getKeyboardInteraction() -> KeyboardInteraction {
        if let keyboardInteraction = self.keyboardInteraction {
            return keyboardInteraction
        } else {
            let keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
            self.keyboardInteraction = keyboardInteraction
            return keyboardInteraction
        }
    }
    
    func getEyeTrackingController() -> EyeTrackingController {
        if let eyeTrackingController = self.eyeTrackingController {
            return eyeTrackingController
        } else {
            let eyeTrackingController = EyeTrackingController(eyeTracker: EyeTracker(), wordSuggestion: WordSuggestion())
            self.eyeTrackingController = eyeTrackingController
            return eyeTrackingController
        }
    }
    
    func getGazeDetection() -> GazeDetection {
        if let gazeDetection = self.gazeDetection {
            return gazeDetection
        } else {
            let calibrationDelegate = YourCalibrationDelegateImplementation() // Replace with your concrete implementation conforming to CalibrationDelegate
            let gazeDetection = GazeDetection(calibrationDelegate: calibrationDelegate)
            self.gazeDetection = gazeDetection
            return gazeDetection
        }
    }
    
    func getTextEntry() -> TextEntry {
        if let textEntry = self.textEntry {
            return textEntry
        } else {
            let textEntry = TextEntry()
            self.textEntry = textEntry
            return textEntry
        }
    }
    
    func getSettings() -> Settings {
        if let settings = self.settings {
            return settings
        } else {
            let settings = Settings.shared
            self.settings = settings
            return settings
        }
    }
    
    func getWordSuggestion() -> WordSuggestion {
        if let wordSuggestion = self.wordSuggestion {
            return wordSuggestion
        } else {
            let wordSuggestion = WordSuggestion()
            self.wordSuggestion = wordSuggestion
            return wordSuggestion
        }
    }
}

