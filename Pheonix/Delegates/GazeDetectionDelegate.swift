import Foundation
import CoreGraphics

protocol GazeDetectionDelegate: AnyObject {
    func gazeDetection(didDetectGazeAt point: CGPoint)
}
