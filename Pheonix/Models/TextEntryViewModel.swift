import Foundation
import Combine

class TextEntryViewModel: ObservableObject {
    @Published var textEntryState: TextEntryState
    
    private let textEntryService: TextEntryService
    
    init(textEntryService: TextEntryService) {
        self.textEntryService = textEntryService
        self.textEntryState = textEntryService.textEntryStateSubject.value.textEntryState
        
        // Additional setup or subscriptions if needed
    }
    
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        let result = textEntryService.addCharacter(character)
        switch result {
            case .success(let appState):
                return .success(appState.textEntryState)
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func deleteLastCharacter() {
        textEntryService.deleteLastCharacter()
    }
}
