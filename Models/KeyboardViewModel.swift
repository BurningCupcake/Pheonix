//The KeyboardViewModel class is an observable object that manages the state and services related to the keyboard. It includes the following properties and methods:

//appState: An observable property representing the current state of the keyboard application. It is marked with @Published to automatically publish changes to the subscribers.
//textEntryService: An instance of TextEntryService that handles text entry-related operations.
//predictiveTextService: An instance of PredictiveTextService that provides predictive text suggestions.
//cancellables: A set of AnyCancellable objects to keep track of the subscriptions.
//In the initializer, the initial state of the app is set with an empty text entry state and an empty predictive text state. The textEntryService and predictiveTextService are instantiated.

//The textEntryService.textEntryStatePublisher is subscribed to using the sink operator from Combine. Whenever a new textEntryState is received, the appState is updated with the new text entry state and the existing predictive text state. This allows the app state to be kept up-to-date with changes in the text entry service.

//Overall, the KeyboardViewModel class provides a centralized point for managing the state and services related to the keyboard functionality. It utilizes Combine's publishers and subscribers to handle changes in the text entry service and update the app state accordingly.

import Foundation
import Combine

class KeyboardViewModel: ObservableObject {
    @Published var appState: AppState
    
    let textEntryService: TextEntryService
    let predictiveTextService: PredictiveTextService
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let initialTextEntryState = TextEntryState(text: "")
        let initialPredictiveTextState = PredictiveTextState(suggestions: [])
        appState = AppState(
            textEntryState: initialTextEntryState,
            predictiveTextState: initialPredictiveTextState
        )
        
        textEntryService = TextEntryService()
        predictiveTextService = PredictiveTextService()
        
        textEntryService.textEntryStatePublisher
            .sink { [weak self] textEntryState in
                self?.appState = AppState(
                    textEntryState: textEntryState,
                    predictiveTextState: self?.appState.predictiveTextState ?? initialPredictiveTextState
                )
            }
            .store(in: &cancellables)
    }
}
