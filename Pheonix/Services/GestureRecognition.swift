import Foundation
import UIKit

protocol GestureRecognitionDelegate: AnyObject {
    func didRecognizeGesture(_ gesture: GestureType)
}

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    
    // Constants for gesture recognition
    private let blinkDurationThreshold: TimeInterval = 0.3
    private let swipeThreshold: CGFloat = 50.0
    
    private var initialTouchPoint: CGPoint?
    private var initialTouchTime: TimeInterval?
    
    func processTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        initialTouchPoint = touch.location(in: touch.view)
        initialTouchTime = touch.timestamp
    }
    
    func processTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let initialPoint = initialTouchPoint,
              let initialTime = initialTouchTime
        else {
            return
        }
        
        let finalPoint = touch.location(in: touch.view)
        let finalTime = touch.timestamp
        
        let duration = finalTime - initialTime
        let distance = calculateDistance(from: initialPoint, to: finalPoint)
        
        if duration <= blinkDurationThreshold {
            delegate?.didRecognizeGesture(.blink)
        } else if distance >= swipeThreshold {
            detectSwipeGesture(from: initialPoint, to: finalPoint)
        }
        
        // Reset values
        initialTouchPoint = nil
        initialTouchTime = nil
    }
    
    private func calculateDistance(from startPoint: CGPoint, to endPoint: CGPoint) -> CGFloat {
        let deltaX = endPoint.x - startPoint.x
        let deltaY = endPoint.y - startPoint.y
        
        return sqrt(pow(deltaX, 2) + pow(deltaY, 2))
    }
    
    private func detectSwipeGesture(from startPoint: CGPoint, to endPoint: CGPoint) {
        let horizontalDistance = endPoint.x - startPoint.x
        let verticalDistance = endPoint.y - startPoint.y
        
        if abs(horizontalDistance) > abs(verticalDistance) {
            if horizontalDistance > 0 {
                delegate?.didRecognizeGesture(.swipeRight)
            } else {
                delegate?.didRecognizeGesture(.swipeLeft)
            }
        } else {
            if verticalDistance > 0 {
                delegate?.didRecognizeGesture(.swipeDown)
            } else {
                delegate?.didRecognizeGesture(.swipeUp)
            }
        }
    }
}
