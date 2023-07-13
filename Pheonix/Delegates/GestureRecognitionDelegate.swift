import UIKit

protocol GestureRecognitionDelegate: AnyObject {
    func gestureRecognition(_ gestureRecognition: GestureRecognition, didRecognizeSwipeDirection direction: UISwipeGestureRecognizer.Direction)
    func gestureRecognitionDidDetectTap(_ gestureRecognition: GestureRecognition)
    func gestureRecognitionDidDetectLongPress(_ gestureRecognition: GestureRecognition)
}

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    
    private var swipeGestureRecognizer: UISwipeGestureRecognizer!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    init() {
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGestureRecognizer.direction = [.up, .down, .left, .right]
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        longPressGestureRecognizer.minimumPressDuration = 1.0
        
        let gestures: [UIGestureRecognizer] = [swipeGestureRecognizer, tapGestureRecognizer, longPressGestureRecognizer]
        for gesture in gestures {
            gesture.delegate = self
        }
    }
    
    @objc private func handleSwipeGesture(_ recognizer: UISwipeGestureRecognizer) {
        delegate?.gestureRecognition(self, didRecognizeSwipeDirection: recognizer.direction)
    }
    
    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        delegate?.gestureRecognitionDidDetectTap(self)
    }
    
    @objc private func handleLongPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            delegate?.gestureRecognitionDidDetectLongPress(self)
        }
    }
}

extension GestureRecognition: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

