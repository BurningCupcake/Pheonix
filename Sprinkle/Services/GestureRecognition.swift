import Foundation

protocol GestureRecognitionDelegate: AnyObject {
    func gestureRecognition(_ gestureRecognition: GestureRecognition, didRecognizeGesture gesture: GestureType)
}

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    private var previousEyeState: EyeState = .open
    
    func processEyeState(_ eyeState: EyeState) {
        if previousEyeState == .open && eyeState == .closed {
            delegate?.gestureRecognition(self, didRecognizeGesture: .blink)
        }
        previousEyeState = eyeState
    }
}


