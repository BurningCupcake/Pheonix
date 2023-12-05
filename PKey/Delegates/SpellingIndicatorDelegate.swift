import Foundation

// Protocol definition for handling spelling-related updates
protocol SpellingIndicatorDelegate: AnyObject {
    // Method to be called when spelling correctness needs to be updated
    func updateSpellingIndicator(isSpellingCorrect: Bool)
    
    // Method to be called for updating word suggestions
    func updateWordSuggestions(suggestions: [String])
}

// Extension to provide default implementations of the protocol methods
extension SpellingIndicatorDelegate {
    func updateSpellingIndicator(isSpellingCorrect: Bool) {
        // Default implementation can be empty or contain some basic logic.
        // This method can be overridden in conforming classes.
    }
    
    func updateWordSuggestions(suggestions: [String]) {
        // Default implementation can be empty or contain some basic logic.
        // This method can be overridden in conforming classes.
    }
}
