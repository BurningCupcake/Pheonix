import Foundation

protocol KeyboardViewDelegate: AnyObject {
    var keyboardView: KeyboardView? { get set }
    func didSelectKey(_ key: String)
}
