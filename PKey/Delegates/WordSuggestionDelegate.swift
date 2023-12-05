import Foundation

// Protocol `WordSuggestionDelegate` is declared.
// It is a blueprint that describes methods that are required to be implemented 
// by any conforming class or struct.
// It is declared as `AnyObject` so it indicates that we can only conform to this protocol with class types.
protocol WordSuggestionDelegate: AnyObject {
    // `wordSuggestion(_:didSuggestWords:)` method is declared.
    // Any class/struct conforming to `WordSuggestionDelegate` protocol 
    // needs to implement this method.
    // This method acts as a callback after a word suggestion has been made. 
    // It passes the `WordSuggestion` instance that suggested the words and
    // the array of suggested words.
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String])
}
