import Foundation

class WordSuggestionDelegateWrapper: WordSuggestionDelegate {
    @Published var suggestedWords: [String] = []
    
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String]) {
        self.suggestedWords = suggestedWords
    }
}
