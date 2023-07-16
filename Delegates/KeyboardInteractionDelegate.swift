import Foundation

protocol KeyboardInteractionDelegate: AnyObject {
    func didSelectKey(_ key: String, textEntryService: TextEntryService)
    // Add any additional delegate methods for keyboard interaction events
}

extension KeyboardInteractionDelegate {
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        // Default implementation for handling key selection
        // You can override this method in conforming classes to handle the selected key
    }
}
