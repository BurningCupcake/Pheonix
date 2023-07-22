//The TextEntry class provides methods to manipulate the current text. The currentText property is used to store the current text value and is accessible through a private setter.

//The appendText method appends the given text to the current text value. It modifies the currentText string by appending the provided text.

//The deleteLastCharacter method removes the last character from the currentText string. It uses the popLast() method to remove and return the last character of the string.

//The clearText method resets the currentText value to an empty string.

//These methods allow manipulating the current text entry by appending text, deleting the last character, or clearing the entire text.

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
