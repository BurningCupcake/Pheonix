import Foundation

class TextEntry {
    var currentText: String = ""
    
    func appendText(_ text: String) {
        currentText += text
    }
    
    func deleteLastCharacter() {
        _ = currentText.popLast()
    }
}
