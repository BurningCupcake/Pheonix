import Foundation
import Combine
import SwiftUI

class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    @Published var wordSuggestions: [String] = []
    @Published var spellingIndicator: Bool
    private let textChecker = UITextChecker()
    
    init(spellingIndicator: Bool = true) {
        self.spellingIndicator = spellingIndicator
    }
    
    func didSelectKey(_ key: String) {
        // Handle key selection event
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
    
    func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        spellingIndicator = isSpellingCorrect
    }
    
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
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
    }
    
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
}
