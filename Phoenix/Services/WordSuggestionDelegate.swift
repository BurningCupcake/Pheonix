import Foundation

protocol WordSuggestionDelegate: AnyObject {
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String])
}
