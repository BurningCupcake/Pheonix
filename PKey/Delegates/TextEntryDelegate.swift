import Foundation

protocol TextEntryDelegate: AnyObject {
    // This method will be called when the text is updated
    func textEntry(_ textEntry: TextEntry, didUpdateText text: String)
}
