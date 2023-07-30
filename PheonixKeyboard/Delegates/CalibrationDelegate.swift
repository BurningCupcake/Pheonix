// Importing UIKit to access user interface kit module
import UIKit
// Importing CoreGraphics to access data structures and functions necessary for drawing 2D graphics
import CoreGraphics
// Importing QuartzCore to access the animations and graphics rendering capabilities, including both 2D vector graphics (through Core Animation) and OpenGL ES 2D texture-based rendering
import QuartzCore

// Declaring a CalibrationDelegate protocol with methods to manage calibration operations
protocol CalibrationDelegate {
    // Set off when calibration starts
    func didStartCalibration()
    // Set off when calibration completes and a CalibrationResult is produced
    func didCompleteCalibration(withResult: CalibrationResult)
    // Set off when calibration fails and produces an Error
    func didFailCalibration(withError: Error)
}
