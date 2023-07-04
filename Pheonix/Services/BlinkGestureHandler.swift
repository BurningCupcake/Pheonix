import Foundation

class BlinkGestureHandler {
    weak var delegate: BlinkGestureHandlerDelegate?
    private var previousEyeState: EyeState = .open
    
    func processEyeState(_ eyeState: EyeState) {
        if previousEyeState == .open && eyeState == .closed {
            delegate?.didDetectBlink()
        }
        previousEyeState = eyeState
    }
}
