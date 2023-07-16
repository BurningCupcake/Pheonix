
import ARKit
import SwiftUI

class EyeTrackingController: NSObject, ARSessionDelegate, GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate {
    var session: ARSession
    var eyeTracker: EyeTracker
    var textChecker: UITextChecker  // Add UITextChecker instance
    var gazeDirection: SCNVector3 = SCNVector3Zero

    
    init(eyeTracker: EyeTracker) {
        self.session = ARSession()
        self.eyeTracker = eyeTracker
        self.textChecker = UITextChecker()  // Initialize UITextChecker
        super.init()
        self.session.delegate = self
    }
    
    func startTracking() {
        let configuration = ARFaceTrackingConfiguration()
        self.session.run(configuration)
    }
    
    func stopTracking() {
        self.session.pause()
    }
    
    // ARSessionDelegate method
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
        let leftEyeTransform = faceAnchor.leftEyeTransform
        let rightEyeTransform = faceAnchor.rightEyeTransform
        // Calculate the gaze direction
        let leftEyeDirection = SCNVector3(leftEyeTransform.columns.3.x, leftEyeTransform.columns.3.y, leftEyeTransform.columns.3.z)
        let rightEyeDirection = SCNVector3(rightEyeTransform.columns.3.x, rightEyeTransform.columns.3.y, rightEyeTransform.columns.3.z)
        
        // Average the two vectors to get the overall gaze direction
        gazeDirection = SCNVector3((leftEyeDirection.x + rightEyeDirection.x) / 2, (leftEyeDirection.y + rightEyeDirection.y) / 2, (leftEyeDirection.z + rightEyeDirection.z) / 2)

        
        // Now you can use the gazeDirection vector for your gaze detection logic
    }
    
    // GazeDetectionDelegate method
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        // Implement this method based on your gaze detection logic
    }
    
    // KeyboardInteractionDelegate method
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String) {
        // Implement this method based on your keyboard interaction logic
    }
    
    // WordSuggestionDelegate methods
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        // Implement this method to provide word suggestions based on the results from the UITextChecker
    }
}
