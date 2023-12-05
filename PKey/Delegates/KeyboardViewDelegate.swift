import Foundation
import UIKit

protocol KeyboardViewDelegate: AnyObject {
    func didSelectKey(_ key: String, textEntryService: TextEntryService)
    func updateWordSuggestions(_ suggestions: [String])
    func updateSpellingIndicator(_ isSpellingCorrect: Bool)
}

class SomeClass: KeyboardViewDelegate {
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            let result = textEntryService.addCharacter(key)
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                    let textChecker = UITextChecker()
                    let completions = textChecker.completions(forPartialWordRange: NSRange(location: 0, length: state.text.utf16.count), in: state.text, language: "en_US")
                    let suggestions = completions ?? []
                    updateWordSuggestions(suggestions)
                case .failure(let error):
                    print("Error adding character: \(error)")
            }
        } else if key == " " {
            let result = textEntryService.addCharacter(" ")
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                case .failure(let error):
                    print("Error adding space: \(error)")
            }
        } else if key == "<" {
            textEntryService.deleteLastCharacter()
        }
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        // Implement this method
    }
    
    func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        // Implement this method
    }
}
