//The protocol contains a single method:

//didDetectBlink(): This method is called when a blink gesture is detected. Classes or structs that adopt the BlinkGestureHandlerDelegate protocol need to implement this method to provide custom behavior in response to the blink gesture detection.
//By using this protocol, you can define a delegate object that receives notifications about blink gestures and performs the appropriate actions in response to them.

import Foundation

protocol BlinkGestureHandlerDelegate: AnyObject {
    func didDetectBlink()
}

