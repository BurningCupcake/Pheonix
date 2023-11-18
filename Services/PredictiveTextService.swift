import Foundation
import Combine
import UIKit  // Import UIKit for UITextChecker

class PredictiveTextService {
    
    private let predictiveTextStateSubject = CurrentValueSubject<PredictiveTextState, Never>(PredictiveTextState(suggestions: []))
    
    var predictiveTextStatePublisher: AnyPublisher<PredictiveTextState, Never> {
        return predictiveTextStateSubject.eraseToAnyPublisher()
    }
    
    // Updated method to use UITextChecker for word predictions
    func updatePredictiveText(for text: String) {
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let wordRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en")
        let completions: [String]
        if wordRange.location != NSNotFound {
            completions = textChecker.guesses(forWordRange: wordRange, in: text, language: "en") ?? []
        } else {
            completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en") ?? []
        }
        
        let predictiveTextState = PredictiveTextState(suggestions: completions)
        predictiveTextStateSubject.send(predictiveTextState)
    }
    
    // Optional method to get a specific number of predictions
    func getPredictions(for text: String, numberOfPredictions: Int) -> [String] {
        let allPredictions = getPredictions(from: text)
        return Array(allPredictions.prefix(numberOfPredictions))
    }
    
    // Helper method to get predictions from text
    private func getPredictions(from text: String) -> [String] {
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: text.utf16.count)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en") ?? []
        return completions
    }
}
