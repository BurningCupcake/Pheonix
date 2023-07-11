import Foundation
import Combine

class TextEntryService {
    private let textEntryStateSubject = CurrentValueSubject<AppState, Never>(AppState(textEntryState: TextEntryState(text: ""), predictiveTextState: PredictiveTextState(suggestions: [])))
    
    var textEntryStatePublisher: AnyPublisher<AppState, Never> {
        return textEntryStateSubject.eraseToAnyPublisher()
    }
    
    private var textEntry: TextEntry
    private var predictiveTextState: PredictiveTextState
    
    init() {
        textEntry = TextEntry()
        predictiveTextState = PredictiveTextState(suggestions: [])
    }
    
    func addCharacter(_ character: String) -> Result<AppState, TextEntryError> {
        textEntry.appendText(character)
        
        let updatedAppState = AppState(
            textEntryState: TextEntryState(text: textEntry.currentText),
            predictiveTextState: predictiveTextState
        )
        
        if updatedAppState.textEntryState.text.count > 10 {
            return .failure(.textTooLong)
        }
        
        textEntryStateSubject.send(updatedAppState)
        return .success(updatedAppState)
    }
    
    func deleteLastCharacter() {
        textEntry.deleteLastCharacter()
        
        let updatedAppState = AppState(
            textEntryState: TextEntryState(text: textEntry.currentText),
            predictiveTextState: predictiveTextState
        )
        
        textEntryStateSubject.send(updatedAppState)
    }
}

enum TextEntryError: Error {
    case textTooLong
}
