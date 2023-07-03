import ARKit

protocol GazeDetectionDelegate: AnyObject {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
}

class GazeDetection: NSObject, ARSessionDelegate {
    weak var delegate: GazeDetectionDelegate?
    private var isCalibrating: Bool = false
    
    private var eyeTrackingSession: ARSession
    
    override init() {
        eyeTrackingSession = ARSession()
        super.init()
        eyeTrackingSession.delegate = self
    }
    
    func start() {
        let configuration = ARFaceTrackingConfiguration()
        eyeTrackingSession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stop() {
        eyeTrackingSession.pause()
    }
    
    // MARK: - ARSessionDelegate
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard !isCalibrating, let faceAnchor = anchors.first(where: { $0 is ARFaceAnchor }) as? ARFaceAnchor else {
            return
        }
        
        let leftEyeTransform = SCNMatrix4(faceAnchor.leftEyeTransform)
        let rightEyeTransform = SCNMatrix4(faceAnchor.rightEyeTransform)
        
        let middleEyePosition = SCNVector3(
            (leftEyeTransform.m41 + rightEyeTransform.m41) / 2,
            (leftEyeTransform.m42 + rightEyeTransform.m42) / 2,
            (leftEyeTransform.m43 + rightEyeTransform.m43) / 2
        )
        
        let projectedPoint = eyeTrackingSession.projectPoint(middleEyePosition)
        let gazePoint = CGPoint(x: CGFloat(projectedPoint.x), y: CGFloat(projectedPoint.y))
        delegate?.gazeDetection(self, didDetectGazeAt: gazePoint)
    }
}
