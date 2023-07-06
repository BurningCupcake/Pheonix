import UIKit

class SwipeToTypeController: NSObject {
    
    var currentPath: UIBezierPath?
    var currentWord: String?
    
    func addPointToCurrentPath(_ point: CGPoint) {
        if currentPath == nil {
            currentPath = UIBezierPath()
            currentPath?.move(to: point)
        } else {
            currentPath?.addLine(to: point)
        }
    }
}
