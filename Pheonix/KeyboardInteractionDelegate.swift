import Foundation

protocol KeyboardInteractionDelegate: AnyObject {
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String)
}
