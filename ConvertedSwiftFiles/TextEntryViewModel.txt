//The TextEntryViewModel class is responsible for managing the text entry state and interacting with the TextEntryService.

//Here's a breakdown of the key components:

//textEntryState: An @Published property that represents the current state of the text entry. It's initially set to an instance of TextEntryState with an empty text.
//textEntryService: An instance of the TextEntryService class, which handles the logic for text entry operations.
//textEntryStateCancellable: An AnyCancellable object that represents the subscription to the textEntryStatePublisher of the TextEntryService. It assigns the received state to the textEntryState property whenever a new state is published.
//init(textEntryService:): The initializer of the view model. It takes an instance of TextEntryService as a parameter and sets up the initial state and the subscription to the textEntryStatePublisher using the assign(to:on:) method.
//addCharacter(_:): A method used to add a character to the text entry. It calls the addCharacter(_:) method of the TextEntryService and handles the result. If the operation is successful, it returns the updated text entry state wrapped in a Result.success case. If there's an error, it returns the error wrapped in a Result.failure case.
//deleteLastCharacter(): A method used to delete the last character from the text entry. It calls the deleteLastCharacter() method of the TextEntryService.
//By using the TextEntryViewModel and its textEntryState property, you can observe and retrieve the current state of the text entry in your SwiftUI views. The view model interacts with the TextEntryService to perform text entry operations and update the state accordingly.

import Foundation
import Combine

class TextEntryViewModel: ObservableObject {
    @Published var textEntryState: TextEntryState
    
    private let textEntryService: TextEntryService
    private var textEntryStateCancellable: AnyCancellable?
    
    init(textEntryService: TextEntryService) {
        self.textEntryService = textEntryService
        self.textEntryState = TextEntryState(text: "")
        
        textEntryStateCancellable = textEntryService.textEntryStatePublisher
            .assign(to: \.textEntryState, on: self)
        
        // Additional setup or subscriptions if needed
    }
    
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        let result = textEntryService.addCharacter(character)
        switch result {
            case .success(let updatedTextEntryState):
                return .success(updatedTextEntryState)
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func deleteLastCharacter() {
        textEntryService.deleteLastCharacter()
    }
}
