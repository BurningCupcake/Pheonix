import Foundation
import Combine

class TextEntryService {
    private let textEntryStateSubject = CurrentValueSubject<TextEntryState, Never>(.empty)
    
    var textEntryStatePublisher: AnyPublisher<TextEntryState, Never> {
        return textEntryStateSubject.eraseToAnyPublisher()
    }
    
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        // Add character to text entry state
        // ...
        
        if textEntryState.text.count > 10 {
            return .failure(.textTooLong)
        }
        
        textEntryStateSubject.send(textEntryState)
        return .success(textEntryState)
    }
}

enum TextEntryError: Error {
    case textTooLong
}
