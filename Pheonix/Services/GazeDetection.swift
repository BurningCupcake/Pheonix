// **GazeDetection.swift**

//In this file, we have the GazeDetection class that inherits from NSObject and conforms to the ARSessionDelegate protocol.

//The GazeDetection class is responsible for detecting the user's gaze using ARKit. Here are the key points:

//The class has a delegate property of type GazeDetectionDelegate to notify the gaze detection events.
//The eyeTrackingSession property represents the ARSession used for eye tracking.
//The calibrationDelegate property is an instance of DynamicCalibration used for calibration purposes.
//In the init(calibrationDelegate:) initializer, the ARSession is set up and the delegate is assigned.
//The start() method runs the ARFaceTrackingConfiguration on the eyeTrackingSession to start eye tracking.
//The stop() method pauses the eyeTrackingSession.
//The session(_:didUpdate:) method is called when the ARSession updates with a new frame. It extracts the eye transformation data from the ARFaceAnchor and calculates the gaze point based on the eye positions.
//The calculated gaze point is transformed into the appropriate coordinate space based on the device's orientation and viewport size.
// The delegate?.gazeDetection(_:didDetectGazeAt:) method is called to notify the delegate about the detected gaze point.

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
