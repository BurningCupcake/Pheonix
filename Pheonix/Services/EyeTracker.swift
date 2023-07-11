import ARKit

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
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        let leftEyeTransform = faceAnchor.leftEyeTransform
        let gazePoint = CGPoint(x: CGFloat(leftEyeTransform.columns.3.x), y: CGFloat(leftEyeTransform.columns.3.y))
        
        delegate?.eyeTracker(self, didTrackGazePoint: gazePoint)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Handle the AR session failure here
        // You can implement custom error handling logic based on the error provided
        print("AR session failed with error: \(error)")
    }
}
