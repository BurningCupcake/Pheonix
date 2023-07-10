import Foundation

protocol GazeDetectionDelegate: AnyObject {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
}
