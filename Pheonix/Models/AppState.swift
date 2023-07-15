//This file defines several struct types related to the state of the application. Let's break down each one:

//TextEntryState:
//It represents the state of the text entered in the application.
//It has a single property text of type String to store the entered text.
//PredictiveTextState:
//It represents the state of the predictive text suggestions in the application.
//It has a single property suggestions of type [String] to store the suggested words.
//It includes a static property empty that represents an empty state with no suggestions.
//AppState:
//It represents the overall state of the application, combining the text entry state and predictive text state.
//It has two properties: textEntryState of type TextEntryState and predictiveTextState of type PredictiveTextState.
//It includes an initializer to create an instance of the AppState by providing the initial values for the text entry state and predictive text state.
//Overall, these structs define the state of the application, including the entered text and the predictive text suggestions. The AppState struct combines these states to represent the overall application state.

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
