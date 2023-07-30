// Importing necessary modules
import Foundation
import Combine

// Definition of the KeyboardViewModel class which conforms the ObservableObject protocol.
// An ObservableObject can be used as a way to share data between views.
class KeyboardViewModel: ObservableObject {
    
    // A property 'appState' marked with '@Published', means it'll notify the system of updates
    @Published var appState: AppState
    
    // Instance of the service responsible for text Entry.
    let textEntryService: TextEntryService
    
    // Instance of the service responsible for predictive Text Entry.
    let predictiveTextService: PredictiveTextService
    
    // A set to store any cancellable instances.
    private var cancellables = Set<AnyCancellable>()
    
    // Initializer for the Keyboard ViewModel
    init() {
        // initialize the text entry state with no text
        let initialTextEntryState = TextEntryState(text: "")
        
        // Initialize the predictive text state with no suggestions
        let initialPredictiveTextState = PredictiveTextState(suggestions: [])
        
        // Initialize the application state with the initial text entry and predictive text state
        appState = AppState(
            textEntryState: initialTextEntryState,
            predictiveTextState: initialPredictiveTextState
        )
        
        // Initialize the text entry service
        textEntryService = TextEntryService()
        
        // Initialize the predictive text service
        predictiveTextService = PredictiveTextService()
        
        // Subscribing to and handling updates from the text entry service
        textEntryService.textEntryStatePublisher
            .sink { [weak self] textEntryState in
                self?.appState.textEntryState = textEntryState // Update the text entry state in the AppState
            }
            .store(in: &cancellables) // Store the returned cancellable to the cancellables set to avoid the publisher from being garbage collected
        
        // Subscribing to and handling updates from the predictive text service
        predictiveTextService.predictiveTextStatePublisher
            .sink { [weak self] predictiveTextState in
                self?.appState.predictiveTextState = predictiveTextState // Update the predictive text state in the AppState
            }
            .store(in: &cancellables) //Store the returned cancellable to the cancellables set to avoid the publisher from being garbage collected
    }
}
