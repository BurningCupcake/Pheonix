import UIKit
import CoreGraphics
import QuartzCore

// Declaring a CalibrationDelegate protocol with methods to manage calibration operations
protocol CalibrationDelegate: AnyObject {
    // Method triggered when calibration starts
    func didStartCalibration()
    
    // Method triggered when calibration completes and a CalibrationResult is produced
    func didCompleteCalibration(withResult result: CalibrationResult)
    
    // Method triggered when calibration fails and produces an Error
    func didFailCalibration(withError error: Error)
}
