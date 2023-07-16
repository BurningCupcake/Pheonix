import Foundation

protocol GestureRecognitionDelegate: AnyObject {
    func gestureRecognizer(_ recognizer: GestureRecognizer, didRecognizeGesture gestureType: GestureType)
}


enum GestureType {
    case blink
}

