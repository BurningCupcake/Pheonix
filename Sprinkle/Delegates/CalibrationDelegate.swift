import Foundation

protocol CalibrationDelegate: AnyObject {
    func didStartCalibration()
    func didCompleteCalibration(withResult result: CalibrationResult)
    func didFailCalibration(withError error: Error)
}

class YourCalibrationDelegateImplementation: CalibrationDelegate {
    func didStartCalibration() {
        print("Calibration started")
        // Implement your specific logic for when calibration starts
    }
    
    func didCompleteCalibration(withResult result: CalibrationResult) {
        print("Calibration completed with result: \(result)")
        // Implement your specific logic for when calibration completes
    }
    
    func didFailCalibration(withError error: Error) {
        print("Calibration failed with error: \(error)")
        // Implement your specific logic for when calibration fails
    }
}
