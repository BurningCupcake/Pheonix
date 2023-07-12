import Foundation
import Combine

class TextEntryService {
    private let textEntryStateSubject = CurrentValueSubject<TextEntryState, Never>(TextEntryState(text: ""))
    
    var textEntryStatePublisher: AnyPublisher<TextEntryState, Never> {
        return textEntryStateSubject.eraseToAnyPublisher()
    }
    
    private var textEntry: TextEntry
    private var predictiveTextState: PredictiveTextState
    
    init() {
        textEntry = TextEntry()
        predictiveTextState = PredictiveTextState(suggestions: [])
    }
    
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        textEntry.appendText(character)
        
        let updatedTextEntryState = TextEntryState(text: textEntry.currentText)
        
        if updatedTextEntryState.text.count > 10 {
            return .failure(.textTooLong)
        }
        
        textEntryStateSubject.send(updatedTextEntryState)
        return .success(updatedTextEntryState)
    }
    
    func deleteLastCharacter() {
        textEntry.deleteLastCharacter()
        
        let updatedTextEntryState = TextEntryState(text: textEntry.currentText)
        
        textEntryStateSubject.send(updatedTextEntryState)
    }
}

enum TextEntryError: Error {
    case textTooLong
}
