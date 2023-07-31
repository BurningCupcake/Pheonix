import UIKit
import CoreGraphics
import QuartzCore

// Declaring a CalibrationDelegate protocol with methods to manage calibration operations
protocol CalibrationDelegate: AnyObject {
    // MARK: - CalibrationDelegate methods
    
    /// Reports start of calibration.
    func didStartCalibration() {
        print("Calibration started")
    }
    
    /// Reports completion of calibration.
    func didCompleteCalibration(withResult result: CalibrationResult) {
        print("Calibration completed with result: \(result)")
    }
    
    /// Reports failure of calibration.
    func didFailCalibration(withError error: Error) {
        print("Calibration failed with error: \(error)")
    }
