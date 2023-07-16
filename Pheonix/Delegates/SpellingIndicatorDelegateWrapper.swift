import Foundation

class SpellingIndicatorDelegateWrapper: ObservableObject {
    @Published var wordSuggestions: [String] = []
    @Published var spellingIndicator: Bool = false
   
    func updateWordSuggestions(_ suggestions: [String]) {
        self.wordSuggestions = suggestions
    }
}
