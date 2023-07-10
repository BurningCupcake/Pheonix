import Foundation
import Combine

class TextEntryService {
    private let textEntryStateSubject = CurrentValueSubject<AppState, Never>(AppState(textEntryState: TextEntryState(text: ""), predictiveTextState: PredictiveTextState(suggestions: [])))
    
    var textEntryStatePublisher: AnyPublisher<AppState, Never> {
        return textEntryStateSubject.eraseToAnyPublisher()
    }
    
    func addCharacter(_ character: String) -> Result<AppState, TextEntryError> {
        // Add character to text entry state
        var updatedAppState = textEntryStateSubject.value
        updatedAppState.textEntryState.text.append(character)
        
        if updatedAppState.textEntryState.text.count > 10 {
            return .failure(.textTooLong)
        }
        
        textEntryStateSubject.send(updatedAppState)
        return .success(updatedAppState)
    }
    
    func deleteLastCharacter() {
        // Delete the last character from the text entry state
        var updatedAppState = textEntryStateSubject.value
        updatedAppState.textEntryState.text = String(updatedAppState.textEntryState.text.dropLast())
        
        textEntryStateSubject.send(updatedAppState)
    }
}

enum TextEntryError: Error {
    case textTooLong
}
