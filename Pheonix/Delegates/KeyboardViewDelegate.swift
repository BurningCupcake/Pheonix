import Foundation

protocol KeyboardViewDelegate: AnyObject {
    func didSelectKey(_ key: String, textEntryService: TextEntryService)
    func updateWordSuggestions(_ suggestions: [String])
}

extension KeyboardViewDelegate {
    func didSelectKey(_ key: String) {
        // Handle the selection of a key when the user blinks while gazing at it
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            // If the key is a letter, add the letter to the text entry state
            let result = textEntryService.addCharacter(key)
            // Handle the result of adding the character
            switch result {
                case .success(let state):
                    // The character was successfully added, do something with the new state if necessary
                    print("New state: \(state)")
                case .failure(let error):
                    // There was an error adding the character, handle the error
                    print("Error adding character: \(error)")
            }
        } else if key == " " {
            // If the key is a space, add a space to the text entry state
            let result = textEntryService.addCharacter(" ")
            // Handle the result of adding the space
            switch result {
                case .success(let state):
                    // The space was successfully added, do something with the new state if necessary
                    print("New state: \(state)")
                case .failure(let error):
                    // There was an error adding the space, handle the error
                    print("Error adding space: \(error)")
            }
        } else if key == "<" {
            // If the key is a delete key, delete the last character from the text entry state
            textEntryService.deleteLastCharacter()
        }
        // Add other cases as necessary
    }
}
