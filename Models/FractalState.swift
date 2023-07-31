import UIKit

struct FractalState {
    // Calibration points for the current fractal state
    var calibrationPoints: [CGPoint]
    
    // The generated fractal image based on the calibration points
    var fractalImage: UIImage?
    
    /// Initializes a FractalState with given calibration points and fractal image.
    /// - Parameter calibrationPoints: The points used for calibration.
    /// - Parameter fractalImage: The image generated from the calibration.
    init(calibrationPoints: [CGPoint], fractalImage: UIImage) {
        self.calibrationPoints = calibrationPoints
        self.fractalImage = fractalImage
    }
    
    /// Applies the current fractal state to the calibration process.
    /// - Parameter calibration: The calibration process to apply the fractal state to.
    func apply(to calibration: DynamicCalibration) {
        calibration.clearCalibrationPoints()
        calibrationPoints.forEach { calibration.addCalibrationPoint($0) }
        // Assuming DynamicCalibration has a method to set fractal image
        calibration.setFractalImage(fractalImage)
    }
}
