import Foundation
import Combine
import SwiftUI

class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    @Published var wordSuggestions: [String] = []
    @Published var spellingIndicator: Bool = true
    private let textChecker = UITextChecker()
    
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        guard key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil else { return }
        let result = textEntryService.addCharacter(key)
        switch result {
            case .success(let state):
                print("New state: \(state)")
                let completions = getWordCompletions(for: state.text)
                let isSpellingCorrect = performSpellChecking(for: state.text)
                updateWordSuggestions(completions)
                updateSpellingIndicator(isSpellingCorrect)
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
    
    func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        spellingIndicator = isSpellingCorrect
    }
    
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(location: 0, length: text.utf16.count)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
}
