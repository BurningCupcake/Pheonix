
import ARKit
import simd
import UIKit

class GazeDetection: NSObject, ARSessionDelegate {
    weak var delegate: GazeDetectionDelegate?
    private var isCalibrating: Bool = false
    
    private var eyeTrackingSession: ARSession
    private let calibrationDelegate: DynamicCalibration
    
    init(calibrationDelegate: DynamicCalibration) {
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
        
        let leftEyeTransform = SCNMatrix4(faceAnchor.leftEyeTransform)
        let rightEyeTransform = SCNMatrix4(faceAnchor.rightEyeTransform)
        
        let middleEyePosition = SCNVector3(
            (leftEyeTransform.m41 + rightEyeTransform.m41) / 2,
            (leftEyeTransform.m42 + rightEyeTransform.m42) / 2,
            (leftEyeTransform.m43 + rightEyeTransform.m43) / 2
        )
        
        let middleEyePositionFloat3 = simd_float3(middleEyePosition.x, middleEyePosition.y, middleEyePosition.z)
        
        let viewportSize = frame.camera.imageResolution
        
        // Obtain the correct orientation value
        let interfaceOrientation: UIInterfaceOrientation
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let orientation = windowScene.windows.first?.windowScene?.interfaceOrientation {
            interfaceOrientation = orientation
        } else {
            interfaceOrientation = .portrait
        }
        
        let projectedPoint = frame.camera.projectPoint(middleEyePositionFloat3, orientation: interfaceOrientation, viewportSize: viewportSize)
        let gazePoint = CGPoint(x: CGFloat(projectedPoint.x), y: CGFloat(projectedPoint.y))
        delegate?.gazeDetection(self, didDetectGazeAt: gazePoint)
    }
}
