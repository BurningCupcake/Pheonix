import ARKit

protocol GazeDetectionDelegate: class {
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint)
}

class GazeDetection: NSObject, ARSessionDelegate {
    weak var delegate: GazeDetectionDelegate?
    private var isCalibrating: Bool = false
    
    private var eyeTrackingSession: ARSession
    private let calibrationDelegate: CalibrationDelegate
    
    init(calibrationDelegate: CalibrationDelegate) {
        self.calibrationDelegate = calibrationDelegate
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
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let faceAnchor = frame.anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        let gazePoint = // Calculate gaze point based on the face anchor
        
        delegate?.gazeDetection(self, didDetectGazeAt: gazePoint)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Handle AR session failure
    }
}
