import Foundation
import Combine

class WordSuggestion {
    weak var delegate: WordSuggestionDelegate?
    
    // Update the word suggestions with the provided suggestions
    func updateSuggestions(_ suggestions: [String]) {
        delegate?.wordSuggestion(self, didSuggestWords: suggestions)
    }
}
