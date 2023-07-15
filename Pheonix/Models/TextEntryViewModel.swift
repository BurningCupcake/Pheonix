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
