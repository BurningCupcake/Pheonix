// Importing Foundation and UIKit frameworks, which provide the core services and graphical interface needed for building iOS apps.
import Foundation
import UIKit

// Defining a GazeDetectionDelegate protocol.
// This protocol requires the methods for notifying the detection of a gaze and the current interface orientation.
protocol GazeDetectionDelegate: AnyObject {
    // This method is triggered when a gaze is detected.
    // 'gazeDetection' is the instance of the GazeDetection class responsible for triggering the detection,
    // 'point' is the location of the gaze on the screen.
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
    
    // This method is used to get the current interface orientation when detecting a gaze.
    // 'gazeDetection' is the instance of the GazeDetection class responsible for triggering the detection.
    // The return value is a UIInterfaceOrientation which represents the current interface orientation.
    func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation
}
