import Foundation

protocol GazeDetectionDelegate: GazeDetectionSessionDelegate {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
}

