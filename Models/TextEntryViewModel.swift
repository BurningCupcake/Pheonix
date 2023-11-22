import Foundation
import Combine

// TextEntryViewModel class declaration, which conforms to ObservableObject protocol for SwiftUI View updations
class TextEntryViewModel: ObservableObject {
    @Published var textEntryState: TextEntryState  // Published property for observing changes in textEntryState
    
    private let textEntryService: TextEntryService // A service responsible for handling text entry related operations
    private var textEntryStateCancellable: AnyCancellable? // Holds the cancellation token for the publisher subscription
    
    // Initializer for initializing TextEntryService and textEntryState; also establishes bindings to service publisher
    init(textEntryService: TextEntryService) {
        self.textEntryService = textEntryService
        self.textEntryState = TextEntryState(text: "")
        
        // Assign the textEntryStatePublisher's output to the textEntryState variable and store the cancellable
        textEntryStateCancellable = textEntryService.textEntryStatePublisher
            .assign(to: \.textEntryState, on: self)
    }
    
    // Function to add a character in text, handles the success/failure cases from the service and returns the result
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        let result = textEntryService.addCharacter(character)
        switch result {
            case .success(let updatedTextEntryState):
                return .success(updatedTextEntryState)
            case .failure(let error):
                return .failure(error)
        }
    }
    
    // Function to delete the last character from the text using the textEntryService
    func deleteLastCharacter() {
        textEntryService.deleteLastCharacter()
    }
}
