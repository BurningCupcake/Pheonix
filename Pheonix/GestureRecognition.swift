import Foundation
import UIKit

protocol GestureRecognitionDelegate: AnyObject {
    func didDetectBlink()
}

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    private var previousEyeState: EyeState = .open
    
    func processEyeState(_ eyeState: EyeState) {
        if previousEyeState == .open && eyeState == .closed {
            delegate?.didDetectBlink()
        }
        previousEyeState = eyeState
    }
}

enum EyeState {
    case open
    case closed
}
