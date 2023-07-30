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
    // TODO: Implement the logic for updating the PredictiveTextState based on the inputted text.
    func updatePredictiveText(for text: String) {
        let predictiveTextState = PredictiveTextState(suggestions: []) 
        
        predictiveTextStateSubject.send(predictiveTextState)
    }
}
