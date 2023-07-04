import Foundation

protocol KeyboardInteractionDelegate: AnyObject {
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String)
    // Add any additional delegate methods for keyboard interaction events
}

extension KeyboardInteractionDelegate {
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String) {
        // Default implementation for handling key selection
        // You can override this method in conforming classes to handle the selected key
    }
}
