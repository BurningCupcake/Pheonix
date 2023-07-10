import Foundation

class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    @Published var wordSuggestions: [String] = []
    
    func didSelectKey(_ key: String) {
        // Handle key selection event
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
}
