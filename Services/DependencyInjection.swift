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
        if let gazeDetection = self.gazeDetection {
            // If already instantiated, return the existing instance
            return gazeDetection
        } else {
            // Instantiate GazeDetection with DynamicCalibration
            let dynamicCalibration = DynamicCalibration(eyeTracker: self.eyeTracker)
            guard let gazeDetection = GazeDetection(delegate: dynamicCalibration) else {
                fatalError("Could not initialize GazeDetection with DynamicCalibration as delegate")
            }
            self.gazeDetection = gazeDetection
            return gazeDetection
        }
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
// Ensure DynamicCalibration conforms to GazeDetectionDelegate
extension DynamicCalibration: GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        // Implement handling of gaze detection here
        // For example, updating some state or UI based on the detected gaze point
    }
    
    func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation {
        // Return the current interface orientation.
        // This may require accessing the current view controller or window to determine the orientation
        // If DynamicCalibration does not have access to UI components, you may need to pass this information to it from a component that does.
        // For a placeholder return value (modify as needed):
        return .portrait // or another appropriate default value
    }
}
