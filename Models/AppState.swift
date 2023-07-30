import Foundation

// TextEntryState structure to hold the user's text input
struct TextEntryState {
    var text: String // variable to hold the user's text
}

// PredictiveTextState structure to hold the predictive text suggestions for a user's input
// Implements the Equatable protocol allowing instances to be compared for value equality
struct PredictiveTextState: Equatable {
    var suggestions: [String] // Array holding predictive text suggestions
    
    // Static constant, an empty instance of PredictiveTextState with no suggestions
    static let empty = PredictiveTextState(suggestions: [])
}

// AppState structure is a snapshot of the app's state at a point in time
// It includes the state of the entered text and suggested words
struct AppState {
    var textEntryState: TextEntryState // State of the user's text entry
    var predictiveTextState: PredictiveTextState // State of the predictive text suggestions
}
