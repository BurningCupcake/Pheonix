import Foundation

class TextEntry {
    private(set) var currentText: String = ""
    
    func appendText(_ text: String) {
        currentText.append(text)
    }
    
    func deleteLastCharacter() {
        _ = currentText.popLast()
    }
    
    func clearText() {
        currentText = ""
    }
}
