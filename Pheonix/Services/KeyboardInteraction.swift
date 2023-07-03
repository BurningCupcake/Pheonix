import Foundation

class KeyboardInteraction {
    weak var delegate: KeyboardInteractionDelegate?
    private let keyboardLayout: KeyboardLayout
    
    init(layout: KeyboardLayout) {
        self.keyboardLayout = layout
    }
}
