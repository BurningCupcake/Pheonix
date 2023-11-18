
import Foundation
import UIKit

// Delegate protocol for SwipeToTypeController
protocol SwipeToTypeControllerDelegate: AnyObject {
    func didSwipe(in direction: UISwipeGestureRecognizer.Direction)
}
