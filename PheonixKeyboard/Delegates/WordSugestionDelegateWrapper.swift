// Import the Foundation and Combine framework to support basic functionality and to allow reactive programming
import Foundation
import Combine

// Declare WordSuggestionDelegateWrapper class which conforms to ObservableObject and WordSuggestionDelegate
// ObservableObject allows the publisher to notify subscribers / observers of property changes for SwiftUI interface
// WordSuggestionDelegate is a custom protocol that listens for new suggested words
class WordSuggestionDelegateWrapper: ObservableObject, WordSuggestionDelegate {

    // Define a @Published property 'suggestedWords' to facilitate the dynamic update of the array in the SwiftUI interface
    @Published var suggestedWords: [String] = []
    
    // Implement the 'wordSuggestion' function from the WordSuggestionDelegate protocol
    // This function takes in suggestions and updates the 'suggestedWords' array
    // It is invoked when the WordSuggestion instance has new word suggestions
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String]) {
        self.suggestedWords = suggestedWords
    }
}
