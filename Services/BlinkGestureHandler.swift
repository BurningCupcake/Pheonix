import Foundation

// Class responsible for handling blink gestures
class BlinkGestureHandler {
    // Delegate reference, sends a notification when a blink is detected
    weak var delegate: BlinkGestureHandlerDelegate?
    
    // Keeps track of the previous eye state
    private var previousEyeState: EyeState = .open
    
    // Processes the new eye state and checks for a blink gesture
    func processEyeState(_ eyeState: EyeState) {
        // If the eye was open before and it's now closed, it means the user blinked
        if previousEyeState == .open && eyeState == .closed {
            // Notify the delegate about the blink
            delegate?.didDetectBlink()
        }
        
        // Save current state as the previous state for the next processing run
        previousEyeState = eyeState
    }
}
