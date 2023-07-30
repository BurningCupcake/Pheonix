import UIKit

/// A class to handle dynamic calibration.
class DynamicCalibration: CalibrationDelegate {

    /// Array of calibration points.
    private var calibrationPoints: [CGPoint] = []
    
    /// Default initializer.
    init() {}
    
    /// Static function to create an instance of DynamicCalibration.
    static func create() -> DynamicCalibration {
        return DynamicCalibration()
    }
    
    /// Function to add a new calibration point.
    func addCalibrationPoint(_ point: CGPoint) {
        calibrationPoints.append(point)
    }
    
    /// Function to clear all calibration points.
    func clearCalibrationPoints() {
        calibrationPoints.removeAll()
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
    func generateFractal(size: CGSize) -> UIImage {
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
        return image!
    }
    
    /// Function that adds a fractal layer, animates it, then removes it from the given view controller.
    /// Reports completion to the provided completion closure when done.
    func performCalibration(in viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        let fractalLayer = CALayer()
        fractalLayer.frame = viewController.view.bounds
        fractalLayer.backgroundColor = UIColor.white.cgColor
        
        let fractalImage = generateFractal(size: viewController.view.bounds.size)
        fractalLayer.contents = fractalImage.cgImage
        
        viewController.view.layer.insertSublayer(fractalLayer, at: 0)
        
        animateFractalGrowth(fractalLayer)
        incorporateKeys(fractalLayer)
        
        animateColorShift(layer: fractalLayer, fromColor: .white, toColor: .red, duration: 3.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            fractalLayer.removeFromSuperlayer()
            completion(true)
        }
    }
    
    /// Function to animate the growth of a fractal.
    func animateFractalGrowth(_ layer: CALayer) {
        let growthAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        growthAnimation.fromValue = 0.0
        growthAnimation.toValue = 1.0
        growthAnimation.duration = 3.0
        layer.add(growthAnimation, forKey: "transform.scale.y")
    }
    
    /// Function to incorporate keys into a fractal layer.
    func incorporateKeys(_ layer: CALayer) {
        // For instance, if keys are images, you can add them as sublayers here.
    }
    
    /// Function to animate a change in background color over the specified duration.
    func animateColorShift(layer: CALayer, fromColor: UIColor, toColor: UIColor, duration: TimeInterval) {
        let colorChangeAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorChangeAnimation.fromValue = fromColor.cgColor
        colorChangeAnimation.toValue = toColor.cgColor
        colorChangeAnimation.duration = duration
        layer.add(colorChangeAnimation, forKey: "backgroundColor")
    }
    
    /// Function that finalizes the calibration process.
    func finalizeCalibration() {
        // Here you can finalize the calibration process, for example by saving the CalibrationData.
    }
    
    /// Function to determine the point of interest from an array of eye movements and a fractal state.
    /// Currently averages the eye movement positions to find the point of interest.
    func determinePointOfInterest(eyeMovements: [EyeMovement], fractalState: FractalState) -> CGPoint { 
        // sample code: average over the eye movements' position 
    let count = eyeMovements.count if count == 0 { return CGPoint.zero }
        var sumX = 0.0
        var sumY = 0.0
    for movement in eyeMovements {
        sumX += Double(movement.position.x)
        sumY += Double(movement.position.y)
}

let averageX = CGFloat(sumX / Double(count))
let averageY = CGFloat(sumY / Double(count))

return CGPoint(x: averageX, y: averageY)
  
    }

    
    // MARK: - CalibrationDelegate methods
    
     /// Reports start of calibration.
    func didStartCalibration(
    ) {
        // Handle the start of the calibration process
        print(
            "Calibration started"
        )
    }
    
     /// Reports completion of calibration.
    func didCompleteCalibration(
        withResult result: CalibrationResult
    ) {
        // Handle the completion of the calibration process with the provided result
        print(
            "Calibration completed with result: \(result)"
        )
    }
    
      /// Reports failure of calibration.
   func didFailCalibration(
        withError error: Error
    ) {
        // Handle the failure of the calibration process with the provided error
        print(
            "Calibration failed with error: \(error)"
        )
    }
}
