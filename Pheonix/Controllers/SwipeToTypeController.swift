import UIKit

class SwipeToTypeController {
    weak var delegate: SwipeToTypeControllerDelegate?
    
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
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            delegate?.didSwipeLeft()
        }
    }
}
