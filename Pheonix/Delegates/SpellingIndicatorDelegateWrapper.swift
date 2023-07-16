
import Foundation

class SpellingIndicatorDelegateWrapper: ObservableObject {
    @Published var wordSuggestions: [String] = []
    
    func updateWordSuggestions(_ suggestions: [String]) {
        self.wordSuggestions = suggestions
    }
}
