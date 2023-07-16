import Foundation
import UIKit

protocol GazeDetectionDelegate: AnyObject {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
    func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation
}

