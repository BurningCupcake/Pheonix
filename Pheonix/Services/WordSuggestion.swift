// The WordSuggestion class has a delegate property of type WordSuggestionDelegate, which allows it to notify the delegate about suggested words. It also has a lastWord property to keep track of the last processed word to avoid redundant suggestions.

//The processTextEntry method takes a TextEntry object as input and extracts the current word from the text. It checks if the current word is different from the last word and then filters the dictionary of words to find words that have the current word as a prefix. The filtered words are then limited to a maximum number of suggestions (specified by maxSuggestions) and passed to the delegate via the didSuggestWords method. Finally, the last word is updated.

//The resetLastWord method allows resetting the last word to an empty string, which can be useful in certain scenarios.


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
