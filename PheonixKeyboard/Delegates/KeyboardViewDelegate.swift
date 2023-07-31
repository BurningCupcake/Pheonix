/**
    Importing necessary frameworks
*/
import Foundation
import Combine
import SwiftUI

/**
    Delegate protocol for a keyboard view. This will generally be implemented by whatever 
    class is managing the keyboard view.
*/
protocol KeyboardViewDelegate: AnyObject {
    /**
        Called when a key is selected on the keyboard.
        - Parameter key: A string representation of the key pressed
        - Parameter textEntryService: A service for handling text entry
    */
   
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        // Checks if the key is a letter
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            // Try to add the character to the current text
            let result = textEntryService.addCharacter(key)
            switch result {
                case .success(let state):  // Operation successful
                    print("New state: \(state)")
                    let textChecker = UITextChecker()
                    // Get completions for the current partial word
                    let completions = textChecker.completions(forPartialWordRange: NSRange(location: 0, length: state.text.utf16.count),
                                                              in: state.text,
                                                              language: "en_US")
                    let suggestions = completions ?? []  // Default to empty array if `completions` is `nil`
                    // Update the word suggestions
                    self.updateWordSuggestions(suggestions)  
                case .failure(let error):  // Operation failed
                    print("Error adding character: \(error)")
            }
        } else if key == " " {  // Key is a space
            // Try to add a space to the current text
            let result = textEntryService.addCharacter(" ")
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                case .failure(let error):
                    print("Error adding space: \(error)")
            }
        } else if key == "<" {  // Key is a backspace
            // Delete the last character in the current text
            textEntryService.deleteLastCharacter()
        }
        // Add other cases as necessary
    }
}
