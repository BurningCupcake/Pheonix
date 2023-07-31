
import Foundation
import UIKit

// Protocol for notifying delegate about a swipe in any direction
protocol SwipeToTypeControllerDelegate: AnyObject {
    func didSwipe(in direction: UISwipeGestureRecognizer.Direction)
}
