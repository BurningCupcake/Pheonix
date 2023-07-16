import Foundation
import Combine
import SwiftUI

protocol KeyboardViewDelegate: AnyObject {
    func didSelectKey(_ key: String, textEntryService: TextEntryService, textChecker: UITextChecker)  // Add textChecker parameter
    func updateWordSuggestions(_ suggestions: [String])
}

extension KeyboardViewDelegate {
    func didSelectKey(_ key: String, textEntryService: TextEntryService, textChecker: UITextChecker) {  // Add textChecker parameter
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            let result = textEntryService.addCharacter(key)
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                    let completions = textChecker.completions(forPartialWordRange: NSRange(location: 0, length: state.text.utf16.count),
                                                              in: state.text,
                                                              language: "en_US")
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
        // Add other cases as necessary
    }
}
