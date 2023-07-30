import UIKit

// Class to manage dependencies throughout the app 
class DependencyInjection {

    // Singleton instance of DependencyInjection
    static let shared = DependencyInjection()
    
    // Optional instances of dependencies
    var keyboardInteraction: KeyboardInteraction?
    var eyeTrackingController: EyeTrackingController?
    var gazeDetection: GazeDetection?
    var textEntryService: TextEntryService?
    var settings: Settings?
    var eyeTracker: EyeTracker  // Instance of eyeTracker
    
    // Private initializer to prevent multiple instances of DependencyInjection
    private init() {
        self.eyeTracker = EyeTracker()  // Initializing eyeTracker
    }
    
    // Method to get keyboardInteraction instance or create a new one if it doesn't exist
    func getKeyboardInteraction() -> KeyboardInteraction {
        return self.keyboardInteraction ?? {
            let keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: getTextEntryService())
            self.keyboardInteraction = keyboardInteraction
            return keyboardInteraction
        }()
    }
    
    // Method to get eyeTrackingController instance or create a new one if it doesn't exist
    func getEyeTrackingController() -> EyeTrackingController {
        return self.eyeTrackingController ?? {
            let eyeTrackingController = EyeTrackingController(eyeTracker: self.eyeTracker)
            self.eyeTrackingController = eyeTrackingController
            return eyeTrackingController
        }()
    }
    
    // Method to get gazeDetection instance or create a new one if it doesn't exist
    func getGazeDetection() -> GazeDetection {
        return self.gazeDetection ?? {
            let gazeDetection = GazeDetection(calibrationDelegate: DynamicCalibration())
            self.gazeDetection = gazeDetection
            return gazeDetection
        }()
    }
    
    // Method to get textEntryService instance or create a new one if it doesn't exist
    func getTextEntryService() -> TextEntryService {
        return self.textEntryService ?? {
            let textEntryService = TextEntryService()
            self.textEntryService = textEntryService
            return textEntryService
        }()
    }
    
    // Method to get settings instance or create a new one if it doesn't exist
    func getSettings() -> Settings {
        return self.settings ?? {
            let settings = Settings.shared
            self.settings = settings
            return settings
        }()
    }
}
