import Foundation

/// A class to handle spelling suggestions and indicating a spelling error. 
/// This class is an observable object that publishes changes to subscribed views.
class SpellingIndicatorDelegateWrapper: ObservableObject {
    
    /// An array to hold the suggested words for the spelling error. 
    @Published var wordSuggestions: [String] = []
    
    /// A bool to indicate if there is a spelling error.
    @Published var spellingIndicator: Bool = false
   
    /// A function to update the word suggestions array.
    ///
    /// - Parameter suggestions: An array of phrases/words suggested as corrections.
    func updateWordSuggestions(_ suggestions: [String]) {
        self.wordSuggestions = suggestions
    }
}
