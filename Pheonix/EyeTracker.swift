import UIKit
import ARKit

protocol EyeTrackerDelegate: AnyObject {
    func eyeTracker(_ eyeTracker: EyeTracker, didUpdateGazePoint gazePoint: CGPoint)
}

class EyeTracker: NSObject, ARSessionDelegate {
    weak var delegate: EyeTrackerDelegate?
    private var session: ARSession?
    
    func startTracking() {
        guard ARFaceTrackingConfiguration.isSupported else {
            // Face tracking is not supported on this device
            return
        }
        
        let configuration = ARFaceTrackingConfiguration()
        session = ARSession()
        session?.delegate = self
        session?.run(configuration, options: [])
    }
    
    func stopTracking() {
        session?.pause()
    }
    
    // MARK: - ARSessionDelegate
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // Retrieve the face anchor if available
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        // Extract the gaze point from the left eye transform
        let leftEyeTransform = faceAnchor.leftEyeTransform
        let gazePoint = CGPoint(x: CGFloat(leftEyeTransform.columns.3.x), y: CGFloat(leftEyeTransform.columns.3.y))
        
        // Notify the delegate about the gaze point update
        delegate?.eyeTracker(self, didUpdateGazePoint: gazePoint)
    }
}
