import UIKit
import Combine

class SwipeToTypeController: ObservableObject {
    
    weak var delegate: SwipeToTypeControllerDelegate?
    
    @Published var text: String = ""
    
    // Handle swipe gesture with delta and direction
    func handleSwipeGesture(delta: CGFloat, direction: UISwipeGestureRecognizer.Direction) {
        // Process the swipe gesture
        switch direction {
            case .right:
                self.text = "Swiped right with delta \(delta)"
            case .left:
                self.text = "Swiped left with delta \(delta)"
            case .up:
                self.text = "Swiped up with delta \(delta)"
            case .down:
                self.text = "Swiped down with delta \(delta)"
            default:
                self.text = "Unknown swipe direction"
        }
        
        // Optionally call the delegate method
        self.delegate?.didSwipe(in: direction)
    }
    
    func processEyeMovements(_ eyeMovements: [CGPoint]) {
        guard let swipeDirection = interpretSwipe(from: eyeMovements) else { return }
        performSwipeAction(swipeDirection)
    }
    
    private func interpretSwipe(from eyeMovements: [CGPoint]) -> UISwipeGestureRecognizer.Direction? {
        guard eyeMovements.count > 1 else { return nil }
        
        var cumulativeVector = CGVector(dx: 0, dy: 0)
        
        for i in 1..<eyeMovements.count {
            let start = eyeMovements[i - 1]
            let end = eyeMovements[i]
            let vector = CGVector(dx: end.x - start.x, dy: end.y - start.y)
            cumulativeVector.dx += vector.dx
            cumulativeVector.dy += vector.dy
        }
        
       
        
        // Normalize the vector
        let magnitude = sqrt(cumulativeVector.dx * cumulativeVector.dx + cumulativeVector.dy * cumulativeVector.dy)
        guard magnitude != 0 else { return nil }
        
        let normalizedVector = CGVector(dx: cumulativeVector.dx / magnitude, dy: cumulativeVector.dy / magnitude)
        
        return determineSwipeDirection(from: normalizedVector)
    }
    
    // Determine the primary direction of the swipe
    private func determineSwipeDirection(from vector: CGVector) -> UISwipeGestureRecognizer.Direction? {
        let horizontal = abs(vector.dx)
        let vertical = abs(vector.dy)
        
        if horizontal > vertical {
            return vector.dx > 0 ? .right : .left
        } else if vertical > horizontal {
            return vector.dy > 0 ? .down : .up
        } else {
            // If the movement is diagonal or no clear direction, return nil or handle accordingly
            return nil
        }
    }

    
    // Perform actions based on the interpreted swipe direction
    private func performSwipeAction(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
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
        
        self.delegate?.didSwipe(in: direction)
    }
}

