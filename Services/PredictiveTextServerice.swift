import Foundation
import Combine

// `PredictiveTextService` is a class aimed at managing predictive text functionality.
// It is designed to offer suggestions based on the currently inputted text.
class PredictiveTextService {
    
    // `predictiveTextStateSubject` is a CurrentValueSubject that emits the current state of the predictive text.
    // Initial state has an empty array of suggestions.
    private let predictiveTextStateSubject = CurrentValueSubject<PredictiveTextState, Never>(PredictiveTextState(suggestions: []))
    
    // `predictiveTextStatePublisher` is a public computed property that provides a publisher
    // enabling any object to subscribe to changes in the predictive text's state.
    var predictiveTextStatePublisher: AnyPublisher<PredictiveTextState, Never> {
        return predictiveTextStateSubject.eraseToAnyPublisher()
    }
    
    // `updatePredictiveText` is a method that takes in a string and updates the predictive text state based on it.
    // Currently, the state is always reset to the default one, with no suggestions.

   func updatePredictiveText(for text: String) {
    // Split the input text into words
    let words = text.split(separator: " ")

    // If there are no words, reset the predictive text state
    if words.isEmpty {
        let predictiveTextState = PredictiveTextState(suggestions: [])
        predictiveTextStateSubject.send(predictiveTextState)
        return
    }

    // Get the last word
    let lastWord = String(words.last!)

    // Generate suggestions based on the last word
    // This is a placeholder implementation that suggests words that start with the same letter as the last word
    // In a real-world application, you would use a more sophisticated algorithm to generate suggestions
    let suggestions = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"].filter { $0.lowercased().hasPrefix(lastWord.lowercased()) }

    // Update the predictive text state with the new suggestions
    let predictiveTextState = PredictiveTextState(suggestions: suggestions)
    predictiveTextStateSubject.send(predictiveTextState)
}
