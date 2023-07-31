import UIKit

class DependencyInjection {
    
    static let shared = DependencyInjection()
    
    var keyboardInteraction: KeyboardInteraction?
    var eyeTrackingController: EyeTrackingController?
    var gazeDetection: GazeDetection?
    var textEntryService: TextEntryService?
    var settings: Settings?
    var eyeTracker: EyeTracker
    
    private init() {
        self.eyeTracker = EyeTracker()
    }
    
    func getKeyboardInteraction() -> KeyboardInteraction {
        return self.keyboardInteraction ?? {
            let keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: getTextEntryService())
            self.keyboardInteraction = keyboardInteraction
            return keyboardInteraction
        }()
    }
    
    func getEyeTrackingController() -> EyeTrackingController {
        return self.eyeTrackingController ?? {
            let eyeTrackingController = EyeTrackingController() // no parameter required
            self.eyeTrackingController = eyeTrackingController
            return eyeTrackingController
        }()
    }
    
    func getGazeDetection() -> GazeDetection {
        return self.gazeDetection ?? {
            let dynamicCalibration = DynamicCalibration()
            assert(dynamicCalibration is GazeDetectionDelegate)  // ensure DynamicCalibration conforms to GazeDetectionDelegate
            let gazeDetection = GazeDetection(delegate: dynamicCalibration as! GazeDetectionDelegate)
            self.gazeDetection = gazeDetection
            return gazeDetection
        }()
    }
    
    func getTextEntryService() -> TextEntryService {
        return self.textEntryService ?? {
            let textEntryService = TextEntryService()
            self.textEntryService = textEntryService
            return textEntryService
        }()
    }
    
    func getSettings() -> Settings {
        return self.settings ?? {
            let settings = Settings.shared
            self.settings = settings
            return settings
        }()
    }
}
