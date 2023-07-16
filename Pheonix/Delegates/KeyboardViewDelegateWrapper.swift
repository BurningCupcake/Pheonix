import Foundation
import SwiftUI

class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    @Published var wordSuggestions: [String] = []
    private let textChecker = UITextChecker()
    
    func didSelectKey(_ key: String) {
        // Handle key selection event
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
    
    // Additional methods from the KeyboardViewDelegate extension
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        // Handle the selection of a key when the user blinks while gazing at it
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            // If the key is a letter, add the letter to the text entry state
            let result = textEntryService.addCharacter(key)
            // Handle the result of adding the character
            switch result {
                case .success(let state):
                    // The character was successfully added, do something with the new state if necessary
                    print("New state: \(state)")
                    let completions = getWordCompletions(for: state.text)
                    let isSpellingCorrect = performSpellChecking(for: state.text)
                    updateWordSuggestions(completions)
                    updateSpellingIndicator(isSpellingCorrect)
                case .failure(let error):
                    // There was an error adding the character, handle the error
                    print("Error adding character: \(error)")
            }
        }
        // Handle other cases as necessary
    }
    
    // Word completions
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    // Spell checking
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
    
    private func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        // Update the spelling indicator
    }
}
