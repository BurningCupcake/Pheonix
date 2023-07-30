import Foundation

// Updated Gesture Recruiter
class GestureRecognizer {
    // This reference can be `weak`, because it's usually better to prevent strong reference cycles
    weak var delegate: GestureRecognitionDelegate?

    func recognize(_ gestureType: GestureType) {
        // Call the delegate method if any gesture is recognized
        delegate?.gestureRecognizer(self, didRecognizeGesture: gestureType)
    }
}
