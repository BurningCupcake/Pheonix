// UIKit is imported to use its libraries for UI interface tasks etc.
import UIKit
// ARKit is imported to use its libraries for Augmented Reality tasks
import ARKit

// EyeTrackingControllerDelegate protocol comprises of a single method
// The struct/class/entity which conforms to this protocol will have to implement this method
protocol EyeTrackingControllerDelegate: AnyObject {
    func eyeTrackingController(didUpdate pointOfView: SCNVector3) // method to update the point of view vector in eye tracking controller
}

// Main class EyeTrackingController, inheriting NSObject and conforming ARSessionDelegate and ARSCNViewDelegate
class EyeTrackingController: NSObject, ARSessionDelegate, ARSCNViewDelegate {

    weak var delegate: EyeTrackingControllerDelegate? // a weak (to avoid retain cycle) delegate 
    var session: ARSession // object of ARSession
    var gazeDirection: SCNVector3 = SCNVector3Zero // gaze direction set to zero by default
    
    override init() {
        self.session = ARSession() // AR session initialized
        super.init()
        self.session.delegate = self // setting self as the delegate
    }
    
    // Delegate method which gets called whenever the ARSession updates an anchor
    // Checking if the anchor is of type ARFaceAnchor
    // If true, calculate eye gaze directions and call the delgate method
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
        let leftEyeTransform = SCNMatrix4(faceAnchor.leftEyeTransform)
        let rightEyeTransform = SCNMatrix4(faceAnchor.rightEyeTransform)
        
        let leftEyeDirection = SCNVector3(-1 * leftEyeTransform.m31, -1 * leftEyeTransform.m32, -1 * leftEyeTransform.m33)
        let rightEyeDirection = SCNVector3(-1 * rightEyeTransform.m31, -1 * rightEyeTransform.m32, -1 * rightEyeTransform.m33)
        
        gazeDirection = SCNVector3((leftEyeDirection.x + rightEyeDirection.x) / 2, (leftEyeDirection.y + rightEyeDirection.y) / 2, (leftEyeDirection.z + rightEyeDirection.z) / 2)
        
        delegate?.eyeTrackingController(didUpdate: gazeDirection)
    }
    
    // Function to initialize ARKit with a given view
    // It also sets up some configuration for face tracking
    func initializeArKit(with view: ARSCNView) {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        view.session = session
        view.delegate = self
        view.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // Function to stop the ARKit session
    func stopArKit(with view: ARSCNView) {
        view.session.pause()
    }
}
