import Foundation

protocol GestureRecognitionDelegate: AnyObject {
    func gestureRecognition(_ gestureRecognition: GestureRecognition, didRecognizeGesture gesture: GestureType)
}

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    
    func processEyeState(_ eyeState: EyeState) {
        // Implement your logic to recognize gestures based on eye state
        // You can use the eye state to detect blinks, winks, or other gestures
        
        // Example: Detect a blink gesture when the eye state transitions from open to closed
        if eyeState == .closed {
            delegate?.gestureRecognition(self, didRecognizeGesture: .blink)
        }
    }
}
