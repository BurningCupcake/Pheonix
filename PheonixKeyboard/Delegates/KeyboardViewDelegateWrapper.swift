// Foundation provides fundamental system services useful for Swift applications
import Foundation
// Combine introduces a unified, declarative API for processing values over time
import Combine
// SwiftUI allows the creation of user interfaces across Apple platforms in a concise and declarative syntax
import SwiftUI


// `KeyboardViewDelegateWrapper` class conforms to above described protocol and the `ObservableObject` protocol which allows SwiftUI to observe it and respond to changes
class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    // An array that stores word suggestions, published for use in SwiftUI
    @Published var wordSuggestions: [String] = []
    // A boolean that indicates spelling correctness, published for use in SwiftUI
    @Published var spellingIndicator: Bool
    // A private instance of `UITextChecker` used for spelling and completion suggestion
    private let textChecker = UITextChecker()
    
    // Initializer that allows setting of spellingIndicator's initial state
    init(spellingIndicator: Bool = true) {
        self.spellingIndicator = spellingIndicator
    }
    
    // Method to handle selection of a key. Method is left empty for subclass override
    func didSelectKey(_ key: String) {
        // Handle key selection event
    }
    
    // Method that updates the `wordSuggestions` array with a new array of suggestions
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
    
    // Method that updates the `spellingIndicator` boolean with a new value
    func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        spellingIndicator = isSpellingCorrect
    }
    
    // Method that handles the selection of a key and provides spell check and suggestions
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        // guards against non-alphabetical keys
        guard key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil else { return }
        
        // Using the service, we add the character to our text state
        let result = textEntryService.addCharacter(key)
        // Switch through possible result cases from the `.addCharacter()` service function
        switch result {
            case .success(let state):
                // In the case of success, print new state, get word completions and perform spelling check
                print("New state: \(state)")
                let completions = getWordCompletions(for: state.text)
                let isSpellingCorrect = performSpellChecking(for: state.text)
                // Updates word suggestions and spelling indicator
                updateWordSuggestions(completions)
                updateSpellingIndicator(isSpellingCorrect)
            case .failure(let error):
                // In the case of failure, print error
                print("Error adding character: \(error)")
        }
    }
    
    // Private method that returns an array of word suggestions based on current text
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(location: 0, length: text.utf16.count)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    // Private method that checks the spelling of the current text and returns a boolean value depending on the result
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
}
