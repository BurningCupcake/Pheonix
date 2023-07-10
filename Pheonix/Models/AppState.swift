struct AppState {
    var textEntryState: TextEntryState
    var predictiveTextState: PredictiveTextState
        // Add more state properties as needed
    
    init(textEntryState: TextEntryState, predictiveTextState: PredictiveTextState) {
        self.textEntryState = textEntryState
        self.predictiveTextState = predictiveTextState
        // Initialize additional state properties as needed
    }
}
