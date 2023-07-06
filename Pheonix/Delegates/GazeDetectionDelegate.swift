import Foundation
import CoreGraphics

protocol GazeDetectionDelegate: AnyObject {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
}

extension GazeDetectionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        // Default implementation for handling gaze detection
        // You can override this method in conforming classes to handle the gaze point updates
    }
}
