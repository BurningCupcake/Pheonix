import Combine
import SwiftUI
import CoreGraphics

class DynamicCalibrationModel: ObservableObject {
    
    @Published var scale: CGFloat = 1.0
    @Published var offset: CGSize = .zero
    @Published var complexity: CGFloat = 1.0 // Adjust as needed for fractal complexity
    @Published var highlightedAreas: [CGRect] = []
    @Published var calibrationPoints: [CGPoint] = []
    
    private var isCalibrationInProgress = false
    private var gazeDataAnalyzer = GazeDataAnalyzer()
    private var dynamicCalibration: DynamicCalibration
    
    init(dynamicCalibration: DynamicCalibration) {
        self.dynamicCalibration = dynamicCalibration
    }
    func startCalibration() {
        guard !isCalibrationInProgress else { return }
        
        isCalibrationInProgress = true
        // Reset calibration parameters if necessary
        scale = 1.0
        offset = .zero
        complexity = 1.0
        highlightedAreas = []
    }
    
    func adjustCalibrationParameters(basedOnGaze gazePoint: CGPoint) {
        // Simplified fractal bounds; in practice, calculate this based on your fractal view size and position
        let fractalBounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        gazeDataAnalyzer.addGazePoint(gazePoint)
        let smoothedPoint = gazeDataAnalyzer.getSmoothedGazePoint()
        
        DispatchQueue.main.async {
            let adjustments = self.gazeDataAnalyzer.analyzeGazePoint(smoothedPoint, fractalBounds: fractalBounds)
            self.scale += adjustments.scaleAdjustment
            self.offset = CGSize(width: self.offset.width + adjustments.offsetAdjustment.width,
                                 height: self.offset.height + adjustments.offsetAdjustment.height)
            self.highlightedAreas = self.gazeDataAnalyzer.detectInterestAreas()
        }
    }
    
    func stopCalibration() {
        isCalibrationInProgress = false
        
        // Assuming calculateCalibrationResult() provides the CalibrationResult you need to validate.
        guard let calibrationResult = dynamicCalibration.calculateCalibrationResult() else {
            print("Failed to calculate calibration result.")
            return
        }
        
        // Now, properly call the validate method with the calibrationResult.
        let isValid = CalibrationValidator().validate(calibrationResult: calibrationResult)
        
        if isValid {
            print("Calibration successful and validated.")
            // Apply the calibration result here or take necessary actions after successful validation.
        } else {
            print("Calibration failed validation.")
            // Handle the invalid calibration case here.
        }
    }
    
    
    // Additional methods as necessary...
}
