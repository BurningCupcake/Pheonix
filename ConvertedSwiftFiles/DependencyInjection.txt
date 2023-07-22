import UIKit

class DependencyInjection {
    static let shared = DependencyInjection()
    
    // Declare all the dependencies here
    var keyboardInteraction: KeyboardInteraction?
    var eyeTrackingController: EyeTrackingController?
    var gazeDetection: GazeDetection?
    var textEntryService: TextEntryService?
    var settings: Settings?
    var eyeTracker: EyeTracker?
    
    // The private initializer to make sure it remains a singleton
    private init() {}
    
    // Functions to provide dependencies
    
    func getKeyboardInteraction() -> KeyboardInteraction {
        if let keyboardInteraction = self.keyboardInteraction {
            return keyboardInteraction
        } else {
            let keyboardLayout: KeyboardLayout = KeyboardLayout.defaultLayout()
            let keyboardInteraction = KeyboardInteraction(layout: keyboardLayout, textEntryService: getTextEntryService())
            self.keyboardInteraction = keyboardInteraction
            return keyboardInteraction
        }
    }
    
    func getEyeTrackingController() -> EyeTrackingController {
        if let eyeTrackingController = self.eyeTrackingController {
            return eyeTrackingController
        } else {
            let eyeTracker = EyeTracker() // Get the eye tracker dependency
            
            let eyeTrackingController = EyeTrackingController(eyeTracker: eyeTracker)
            self.eyeTrackingController = eyeTrackingController
            return eyeTrackingController
        }
    }
    
    func getGazeDetection() -> GazeDetection {
        if let gazeDetection = self.gazeDetection {
            return gazeDetection
        } else {
            let calibrationDelegate = DynamicCalibration() // Changed to DynamicCalibration
            let gazeDetection = GazeDetection(calibrationDelegate: calibrationDelegate)
            self.gazeDetection = gazeDetection
            return gazeDetection
        }
    }
    
    func getTextEntryService() -> TextEntryService {
        if let textEntryService = self.textEntryService {
            return textEntryService
        } else {
            let textEntryService = TextEntryService()
            self.textEntryService = textEntryService
            return textEntryService
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
}
