import Foundation
import Combine

// This class is used to create word suggestions
class WordSuggestion {
    // This property is used to delegate the word suggestion events
    weak var delegate: WordSuggestionDelegate?
    
    // This function is used to update the word suggestions and pass them to the delegate
    func updateSuggestions(_ suggestions: [String]) {
        delegate?.wordSuggestion(self, didSuggestWords: suggestions)
    }

    // This function is used to process the text entry by generating word suggestions for the current text and then updating them
    func processTextEntry(_ textEntryService: TextEntryService, currentText: String) {
        let suggestions = generateWordSuggestions(for: currentText)
        updateSuggestions(suggestions)
    }

    // This private function is used to generate word suggestions for a piece of text, currently returns an empty array
    private func generateWordSuggestions(for text: String) -> [String] {
        return []
    }
}
