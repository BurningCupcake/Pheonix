// Importing Foundation library
import Foundation

// Declaring a protocol named GestureRecognitionDelegate that can be adopted by classes
protocol GestureRecognitionDelegate: AnyObject {
    
    // This protocol requires any adopting classes to implement this method. It handles the scenario where a certain gesture is recognized.
    // recognizer: the instance of GestureRecognizer that recognized the gesture
    // gestureType: specifies the type of gesture that was recognized
    func gestureRecognizer(_ recognizer: GestureRecognizer, didRecognizeGesture gestureType: GestureType)
}

// Enum representing different type(s) of gesture(s).
// As of now, it only includes blink gesture.
// This enum can be updated to include more gestures in the future
enum GestureType {
    case blink // A type of gesture, blink
}
