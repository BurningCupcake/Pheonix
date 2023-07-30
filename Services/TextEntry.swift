import Foundation

// TextEntry class that handles operations on a piece of text
class TextEntry {
    // A string that represents the current state of the text
    private(set) var currentText: String = ""
    
    // Method that appends additional text to the current text
    func appendText(_ text: String) {
        currentText.append(contentsOf: text)
    }
    
    // Method that deletes the last character from the current text
    func deleteLastCharacter() {
        if !currentText.isEmpty {
            currentText.removeLast()
        }
    }
    
    // Method that clears the current text
    func clearText() {
        currentText = ""
    }
}
