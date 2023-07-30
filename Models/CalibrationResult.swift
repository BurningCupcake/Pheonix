import Foundation
import CoreGraphics

// The `CalibrationResult` struct is used to store the result of a calibration process.
// Currently, it only contains an array of `CGPoint` which represents the calibration points.
// Add more properties if needed depending on the result of the calibration. 
struct CalibrationResult {
    
    // An array to hold CGPoint objects. Each CGPoint represents a calibration point.
    var calibrationPoints: [CGPoint] = []
    
    // Other properties related to calibration result can be added here.
    // For example, successful (Bool), calibrationError (Error?), etc.
}
