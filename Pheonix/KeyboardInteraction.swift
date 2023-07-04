import Foundation

protocol KeyboardInteractionDelegate: AnyObject {
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: Key)
}

class KeyboardInteraction {
    weak var delegate: KeyboardInteractionDelegate?
    private let keyboardLayout: KeyboardLayout
    
    init(layout: KeyboardLayout) {
        self.keyboardLayout = layout
    }
    
    // Keyboard interaction methods go here
    
}

