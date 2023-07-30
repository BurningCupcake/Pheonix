import ARKit import simd import UIKit

// Protocol for any class that wishes to receive gaze // direction updates from GazeDetection. protocol GazeDetectionDelegate: AnyObject { // Method to determine the current interface orientation func currentInterfaceOrientation(for gazeDetection: GazeDetection) -> UIInterfaceOrientation // Method to listen to gaze detection updates func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) }

// Class to handle face tracking configuration and data class GazeDetection: NSObject, ARSessionDelegate {

weak var delegate: GazeDetectionDelegate?

private let eyeTrackingSession: ARSession
// Keeps the state of eye tracking
private var isRunning = false

// Initializer
required init?(delegate: GazeDetectionDelegate) {
    self.delegate = delegate
    self.eyeTrackingSession = ARSession()
    
    // Check if device has TrueDepth camera.
    guard ARFaceTrackingConfiguration.isSupported else {
        return nil
    }
    super.init()
    self.eyeTrackingSession.delegate = self
}

// Thread-safe function to start the eye tracking process
func start() {
    DispatchQueue.main.async {
        guard !self.isRunning else { return }
        self.isRunning = true
        let configuration = ARFaceTrackingConfiguration()
        self.eyeTrackingSession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// Thread-safe function to stop the eye tracking process
func stop() {
    DispatchQueue.main.async {
        guard self.isRunning else { return }
        self.isRunning = false
        self.eyeTrackingSession.pause()
    }
}

// Function to capture updates from AR frame and convert to gaze points
func session(_ session: ARSession, didUpdate frame: ARFrame) {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        guard let self = self else { return }
        guard let faceAnchor = frame.anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        // Compute middle point between left and right eyes
        let leftEyeTransform = SCNMatrix4(faceAnchor.leftEyeTransform)
        let rightEyeTransform = SCNMatrix4(faceAnchor.rightEyeTransform)
        let middleEyePosition = SCNVector3(
            (leftEyeTransform.m41 + rightEyeTransform.m41) / 2,
            (leftEyeTransform.m42 + rightEyeTransform.m42) / 2,
            (leftEyeTransform.m43 + rightEyeTransform.m43) / 2
        )
        
        let middleEyePositionFloat3 = simd_float3(middleEyePosition.x, middleEyePosition.y, middleEyePosition.z)
        
        // Get camera viewport size
        let viewportSize = frame.camera.imageResolution
        
        // Get interface orientation
        let interfaceOrientation = self.delegate?.currentInterfaceOrientation(for: self) ?? .unknown
        
        // Calculate the projected point of the gaze on the screen
        let projectedPoint = frame.camera.projectPoint(middleEyePositionFloat3, orientation: interfaceOrientation, viewportSize: viewportSize)
        
        // Call the delegate method to provide the current gaze point
        DispatchQueue.main.async {
            let gazePoint = CGPoint(x: CGFloat(projectedPoint.x), y: CGFloat(projectedPoint.y))
            self.delegate?.gazeDetection(self, didDetectGazeAt: gazePoint)
        }
    }
} 