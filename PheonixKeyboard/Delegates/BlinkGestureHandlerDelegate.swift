// Importing Foundation framework, which provides core functionality for all Apple's platforms
import Foundation

// Declares a protocol named `BlinkGestureHandlerDelegate`
// This protocol can only be conformed to by class types (hence the `AnyObject` requirement)
protocol BlinkGestureHandlerDelegate: AnyObject {
    
    // A function requirement for protocol conformance
    // When implemented, this function would be called when a blink gesture is detected
    func didDetectBlink()

}
