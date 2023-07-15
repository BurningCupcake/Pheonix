// **DynamicCalibraion.swift**

// In this file, we have the DynamicCalibration class responsible for managing the dynamic calibration process. Here are the key points:

//The class has a private property calibrationPoints of type [CGPoint] that stores the calibration points collected during the calibration process.
//The addCalibrationPoint(_:) method adds a calibration point to the calibrationPoints array.
//The clearCalibrationPoints() method removes all calibration points from the array.
//The calculateCalibrationResult() method calculates the calibration result based on the collected calibration points. In the provided code, it returns a CalibrationResult object initialized with the calibration points. You may need to implement the actual calibration calculation logic.
//The performCalibration(completion:) method performs the calibration process. It creates a CALayer called fractalLayer and adds it as a sublayer to the keyboard view's layer. Then, it animates the background color of the fractalLayer from white to red over a duration of 3 seconds. After the animation completes, the fractalLayer is removed from its superlayer, and the completion closure is called with a true value.


import UIKit

class DynamicCalibration {
    @Published private var calibrationPoints: [CGPoint] = []
    
    func addCalibrationPoint(_ point: CGPoint) {
        calibrationPoints.append(point)
    }
    
    func clearCalibrationPoints() {
        calibrationPoints.removeAll()
    }
    
    func calculateCalibrationResult() -> CalibrationResult? {
        guard !calibrationPoints.isEmpty else {
            return nil
        }
        
        // Perform calibration calculation based on calibration points
        // Return the calibration result
        
        // Example implementation:
        let result = CalibrationResult(calibrationPoints: calibrationPoints)
        return result
    }
    
    func performCalibration(completion: @escaping (Bool) -> Void) {
        let fractalLayer = CALayer()
        fractalLayer.frame = UIScreen.main.bounds
        fractalLayer.backgroundColor = UIColor.white.cgColor
        fractalLayer.contentsGravity = .center
        fractalLayer.contentsScale = UIScreen.main.scale
        fractalLayer.masksToBounds = true
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyboardView = windowScene.windows.first?.rootViewController?.view {
            keyboardView.layer.insertSublayer(fractalLayer, at: 0)
        }
        
        UIView.animate(withDuration: 3.0, animations: {
            fractalLayer.backgroundColor = UIColor.red.cgColor
        }) { (_) in
            fractalLayer.removeFromSuperlayer()
            completion(true)
        }
    }
}
