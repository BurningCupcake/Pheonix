import Foundation

class WordSuggestion {
    weak var delegate: WordSuggestionDelegate?
    private var lastWord = ""
    private let maxSuggestions = 5
    
    private let dictionary: Set<String> = ["this", "is", "just", "an", "example", "of", "some", "words"]
    
    func processTextEntry(_ textEntry: TextEntry) {
        let words = textEntry.currentText.components(separatedBy: " ")
        guard let currentWord = words.last, currentWord != lastWord else {
            return
        }
        
        let suggestedWords = Array(dictionary.filter { $0.hasPrefix(currentWord) }.prefix(maxSuggestions))
        delegate?.wordSuggestion(self, didSuggestWords: suggestedWords)
        
        lastWord = currentWord
    }
    
    func resetLastWord() {
        lastWord = ""
    }
}
