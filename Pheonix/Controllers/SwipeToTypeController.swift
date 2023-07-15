// The SwipeToTypeController class is an ObservableObject that provides functionality for detecting left swipe gestures and notifying the delegate when a swipe occurs. It also exposes a text property that can be observed for changes.

//The class uses a UISwipeGestureRecognizer to detect left swipe gestures. In the init method, the swipe gesture recognizer is configured with the target (the SwipeToTypeController instance itself) and the action (handleSwipeGesture(_:)) to be called when the gesture occurs. The direction of the swipe gesture is set to .left.

//The attach(to:) method attaches the swipe gesture recognizer to the specified view by adding it as a gesture recognizer.

//The detach(from:) method removes the swipe gesture recognizer from the specified view by removing it as a gesture recognizer.

//The handleSwipeGesture(_:) method is called when the swipe gesture recognizer detects a left swipe gesture. If the state of the gesture is .ended, indicating that the swipe has completed, the delegate's didSwipeLeft() method is called.

//The text property is marked with @Published, making it an observable property. Any changes to this property will automatically notify the observers, allowing them to react to the updated value.

import UIKit
import Combine

class SwipeToTypeController: ObservableObject {
    weak var delegate: SwipeToTypeControllerDelegate?
    
    @Published var text: String = ""
    
    private var swipeGesture: UISwipeGestureRecognizer!
    
    init() {
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
    }
    
    func attach(to view: UIView) {
        view.addGestureRecognizer(swipeGesture)
    }
    
    func detach(from view: UIView) {
        view.removeGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            delegate?.didSwipeLeft()
        }
    }
}
