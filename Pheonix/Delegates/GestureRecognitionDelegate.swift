import Foundation

protocol GestureRecognitionDelegate: AnyObject {
    func gestureRecognition(_ gestureRecognition: GestureRecognition, didRecognizeGesture gesture: GestureType)
}

extension GestureRecognitionDelegate {
    func gestureRecognition(_ gestureRecognition: GestureRecognition, didRecognizeGesture gesture: GestureType) {
        // Default implementation for handling gesture recognition
        // You can override this method in conforming classes to handle specific gestures
    }
}
