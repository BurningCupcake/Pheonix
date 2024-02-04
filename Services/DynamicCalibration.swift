import UIKit
import CoreGraphics
import QuartzCore
import simd

/// A class to handle dynamic calibration.
class DynamicCalibration: CalibrationDelegate {
    
    /// Array of calibration points.
    internal var calibrationPoints: [CGPoint] = []
    
    /// The generated fractal image based on the calibration points
    internal var fractalImage: UIImage?
    
    /// Delegate for handling dynamic calibration updates.
    weak var delegate: DynamicCalibrationDelegate?
    
    /// The eye tracker instance.
    var eyeTracker: EyeTracker?
    
    /// Default initializer.
    init(eyeTracker: EyeTracker) {
        self.eyeTracker = eyeTracker
        self.eyeTracker?.delegate = self
    }
    
    /// Function to add a new calibration point.
    func addCalibrationPoint(_ point: CGPoint) {
        calibrationPoints.append(point)
    }
    
    /// Function to clear all calibration points.
    func clearCalibrationPoints() {
        calibrationPoints.removeAll()
    }
    
    /// Function to set the fractal image.
    func setFractalImage(_ image: UIImage?) {
        self.fractalImage = image
    }
    
    /// Function that calculates the CalibrationResult based on the current calibration points.
    /// Returns nil if no calibration points are set.
    func calculateCalibrationResult() -> CalibrationResult? {
        guard !calibrationPoints.isEmpty else {
            return nil
        }
        
        let result = CalibrationResult(calibrationPoints: calibrationPoints)
        return result
    }
    
    /// Function to generate a fractal image.
    func generateFractal(size: CGSize) -> UIImage? {
        let width = Int(size.width)
        let height = Int(size.height)
        let scale = 4.0
        let maxIter = 256
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        
        for x in 0..<width {
            for y in 0..<height {
                var xx = 0.0
                var yy = 0.0
                let cx = Double(x) / Double(width) * scale - scale / 2
                let cy = Double(y) / Double(height) * scale - scale / 2
                
                var iter = 0
                while xx*xx + yy*yy <= 4 && iter < maxIter {
                    let temp = xx*xx - yy*yy + cx
                    yy = 2*xx*yy + cy
                    xx = temp
                    iter += 1
                }
                
                var color = UIColor.white
                if iter < maxIter {
                    color = UIColor(hue: CGFloat(iter) / CGFloat(maxIter), saturation: 1.0, brightness: 1.0, alpha: 1.0)
                }
                
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// Function to start the calibration process.
    func startCalibration() {
        delegate?.didStartCalibration()
        eyeTracker?.startTracking()
    }
    
    /// Function to stop the calibration process.
    func stopCalibration() {
        eyeTracker?.stopTracking()
        guard let result = calculateCalibrationResult() else {
            delegate?.didFailCalibration(withError: CalibrationError.resultNotAvailable)
            return
        }
        delegate?.didCompleteCalibration(withResult: result)
    }
    
    // MARK: - CalibrationDelegate methods
    
    /// Reports start of calibration.
    func didStartCalibration() {
        print("Calibration started")
    }
    
    func didCompleteCalibration(withResult result: CalibrationResult) {
        print("Calibration completed with result: \(result)")
    }
    
    func didFailCalibration(withError error: Error) {
        print("Calibration failed with error: \(error)")
    }
}

// MARK: - EyeTrackerDelegate Extension

extension DynamicCalibration: EyeTrackerDelegate {
    
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        addCalibrationPoint(gazePoint)
        delegate?.dynamicCalibration(self, didUpdateEyeOffset: simd_float3(Float(gazePoint.x), Float(gazePoint.y), 0))
    }
    
    func eyeTrackerDidStartTracking(_ eyeTracker: EyeTracker) {
        // Handle the start of eye tracking if needed
    }
    
    func eyeTrackerDidStopTracking(_ eyeTracker: EyeTracker) {
        // Handle the stop of eye tracking if needed
    }
    
    func eyeTrackerDidFailToStart(_ eyeTracker: EyeTracker) {
        delegate?.didFailCalibration(withError: CalibrationError.trackerNotAvailable)
    }
}

// Define any custom errors related to calibration
enum CalibrationError: Error {
    case resultNotAvailable
    case trackerNotAvailable
}
