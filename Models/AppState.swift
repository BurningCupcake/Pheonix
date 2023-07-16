import Foundation

struct TextEntryState {
    var text: String
}

struct PredictiveTextState: Equatable {
    var suggestions: [String]
    
    static let empty = PredictiveTextState(suggestions: [])
}

struct AppState {
    var textEntryState: TextEntryState
    var predictiveTextState: PredictiveTextState
    
    // Additional properties and initializers
    
    init(textEntryState: TextEntryState, predictiveTextState: PredictiveTextState) {
        self.textEntryState = textEntryState
        self.predictiveTextState = predictiveTextState
    }
}
