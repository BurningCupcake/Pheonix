import ARKit
import CoreGraphics

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
        
        // Perform additional eye tracking logic using faceAnchor
        
        // Extract eye tracking data, such as eye positions or gaze direction
        let leftEyePosition = faceAnchor.leftEyeTransform.columns.3
        let rightEyePosition = faceAnchor.rightEyeTransform.columns.3
        
        // Calculate gaze point based on eye positions
        let gazePoint = calculateGazePoint(leftEyePosition: leftEyePosition, rightEyePosition: rightEyePosition)
        
        // Pass the calculated gaze point to the delegate
        delegate?.eyeTracker(self, didTrackGazePoint: gazePoint)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Handle the AR session failure here
        // You can implement custom error handling logic based on the error provided
        print("AR session failed with error: \(error)")
    }
    
    // MARK: - Gaze Point Calculation
    
    private func calculateGazePoint(leftEyePosition: simd_float4, rightEyePosition: simd_float4) -> CGPoint {
        // Calculate the gaze point based on the eye positions
        // Implement your gaze point calculation logic here
        
        // Example implementation: Average the left and right eye positions
        let averageEyePosition = (leftEyePosition + rightEyePosition) / 2
        
        // Convert the average eye position to screen coordinates
        let gazePoint = CGPoint(x: CGFloat(averageEyePosition.x), y: CGFloat(averageEyePosition.y))
        
        return gazePoint
    }
}
