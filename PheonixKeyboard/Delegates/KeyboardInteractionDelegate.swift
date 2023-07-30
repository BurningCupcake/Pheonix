import Foundation

// Protocol that defines an interace for handling keyboard
// interaction events. Only classes (`AnyObject`) can conform to this protocol.
protocol KeyboardInteractionDelegate: AnyObject {
    // Delegate method that is invoked when a key is selected on the keyboard.
    // - Parameters:
    //   - key: The key that was selected.
    //   - textEntryService: The service used for text entry.
    func didSelectKey(_ key: String, textEntryService: TextEntryService)
    // Add any additional delegate methods for keyboard interaction events
}

// Extension to provide default implementations of the protocol's methods.
extension KeyboardInteractionDelegate {
    // Default implementation for the delegate method that handles when a key is selected.
    // Conforming classes can override this method to provide a custom behavior when a key is selected.
    // - Parameters:
    //   - key: The key that was selected.
    //   - textEntryService: The service used for text entry.
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        // Default implementation for handling key selection
        // You can override this method in conforming classes to handle the selected key
    }
}
