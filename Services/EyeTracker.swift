// UIKit, ARKit, simd and CoreGraphics Libraries imported
import UIKit
import ARKit
import simd
import CoreGraphics

// EyeTracker class that inherits from NSObject and implements ARSession's delegate
class EyeTracker: NSObject, ARSessionDelegate {
    
    // Delegate of EyeTracker
    weak var delegate: EyeTrackerDelegate?
    
    // ARSession which manages motion tracking and camera processing interactions needed for AR
    internal var session: ARSession?
    
    // Current position of gaze point
    var currentPosition: CGPoint = .zero
    
    // Starts the process of tracking the eye movements
    func startTracking() {
        
        // Check if Face Tracking is supported on the device
        guard ARFaceTrackingConfiguration.isSupported else {
            // If not supported, delegate is notified with failure
            delegate?.eyeTrackerDidFailToStart(self)
            return
        }
        
        // Start ARFaceTrackingConfiguration if supported
        let configuration = ARFaceTrackingConfiguration()
        session = ARSession()
        session?.delegate = self
        session?.run(configuration, options: [])
    }
    
    // Function to stop the process of tracking the eye movements
    func stopTracking() {
        session?.pause()
    }
    
    // MARK: - ARSessionDelegate
    
    // ARSession's delegate method which runs every time session's frame is updated
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Check if there's a face anchor in the frame
        guard let faceAnchor = frame.anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        // Calculate transformations for eyes
        let leftEyeTransform = faceAnchor.transform * faceAnchor.leftEyeTransform
        let rightEyeTransform = faceAnchor.transform * faceAnchor.rightEyeTransform
        
        // Get the 3D position of the eyes from transform matrices
        let leftEyePosition = simd_make_float3(leftEyeTransform.columns.3)
        let rightEyePosition = simd_make_float3(rightEyeTransform.columns.3)
        
        // Calculate the actual gaze point of the eyes
        let gazePoint = calculateGazePoint(leftEyePosition: leftEyePosition, rightEyePosition: rightEyePosition)
        
        // Update currentPosition with the new gaze point
        currentPosition = gazePoint
        
        // Notify delegate about update in gaze point
        self.delegate?.eyeTracker(self, didTrackGazePoint: gazePoint)
    }
    
    // Function which runs when there's an error within ARSession
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR session failed with error: \(error)")
    }
    
    // Function to calculate center point between the positions of left and right eyes
    internal func calculateGazePoint(leftEyePosition: simd_float3, rightEyePosition: simd_float3) -> CGPoint {
        let averageEyePosition = (leftEyePosition + rightEyePosition) / 2
        // create CGPoint from average position values
        return CGPoint(x: CGFloat(averageEyePosition.x), y: CGFloat(averageEyePosition.y))
    }
}

