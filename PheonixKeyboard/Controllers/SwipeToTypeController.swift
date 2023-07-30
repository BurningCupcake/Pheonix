import UIKit
import Combine



// Observable object that handles swipe gestures in four directions and updates text property accordingly,
// while also notifying the delegate about the swipe
class SwipeToTypeController: ObservableObject {

    // Delegate reference
    weak var delegate: SwipeToTypeControllerDelegate?
    
    // Gesture recognizers for each swipe direction
    private var swipeLeftGesture: UISwipeGestureRecognizer!
    private var swipeRightGesture: UISwipeGestureRecognizer!
    private var swipeUpGesture: UISwipeGestureRecognizer!
    private var swipeDownGesture: UISwipeGestureRecognizer!
    
    // String that gets updated whenever a swipe occurs
    @Published var text: String = ""
    
    init() {
        // Initialize gesture recognizers for each swipe direction
        swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right
        swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeUpGesture.direction = .up
        swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeDownGesture.direction = .down
    }

    // Function to add the gestures to a view
    func attach(to view: UIView) {
        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
        view.addGestureRecognizer(swipeUpGesture)
        view.addGestureRecognizer(swipeDownGesture)
    }

    // Function to remove the gestures from a view
    func detach(from view: UIView) {
        view.removeGestureRecognizer(swipeLeftGesture)
        view.removeGestureRecognizer(swipeRightGesture)
        view.removeGestureRecognizer(swipeUpGesture)
        view.removeGestureRecognizer(swipeDownGesture)
    }

    // Function to handle the swipe gestures, updates the text and notifies the delegate
    @objc private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            self.text = "Swiped right!"
        case .left:
            self.text = "Swiped left!"
        case .up:
            self.text = "Swiped up!"
        case .down:
            self.text = "Swiped down!"
        default:
            break
        }
        self.delegate?.didSwipe(in: sender.direction)
    }
}
