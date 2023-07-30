import Foundation
import Combine
import UIKit

class TextEntryService: WordSuggestionDelegate {
    private let textEntryStateSubject = CurrentValueSubject<TextEntryState, Never>(TextEntryState(text: ""))
    
    var textEntryStatePublisher: AnyPublisher<TextEntryState, Never> {
        return textEntryStateSubject.eraseToAnyPublisher()
    }
    
    private var textEntry: TextEntry
    private let wordSuggestion: WordSuggestion
    private let textChecker: UITextChecker
    private var keyboardViewDelegateWrapper: KeyboardViewDelegateWrapper?
    
    init() {
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        textChecker = UITextChecker()
        wordSuggestion.delegate = self
    }
    
    func addCharacter(_ character: String, usingEyeGaze: Bool = false, gazePoint: CGPoint? = nil) -> Result<TextEntryState, TextEntryError> {
        var characterToAdd = character
        if usingEyeGaze, let point = gazePoint {
            // Process character input based on eye gaze
            guard let processedCharacter = processCharacterFromGazePoint(point) else {
                return .failure(.invalidGazePoint)
            }
            characterToAdd = processedCharacter
        }
        
        if textEntry.currentText.count + characterToAdd.count > 10 {
            return .failure(.textTooLong)
        }
        
        textEntry.appendText(characterToAdd)
        
        let updatedTextEntryState = TextEntryState(text: textEntry.currentText)
        textEntryStateSubject.send(updatedTextEntryState)
        return .success(updatedTextEntryState)
    }
    
    func deleteLastCharacter() {
        guard !textEntry.currentText.isEmpty else { return }
        textEntry.deleteLastCharacter()
        
        let updatedTextEntryState = TextEntryState(text: textEntry.currentText)
        
        textEntryStateSubject.send(updatedTextEntryState)
    }
    
    private func processCharacterFromGazePoint(_ gazePoint: CGPoint) -> String? {
        // Process the gaze point to determine the character to add based on the keyboard layout or interaction rules
        // Implement your logic here to convert the gaze point to a character
        
        // Example implementation:
        if gazePoint.x < 100 && gazePoint.y < 100 {
            return "A"
        } else if gazePoint.x < 200 && gazePoint.y < 200 {
            return "B"
        } else if gazePoint.x < 300 && gazePoint.y < 300 {
            return "C"
        }
        
        return nil
    }
    
    // MARK: - WordSuggestionDelegate
    
    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords suggestedWords: [String]) {
        // Pass the suggested words to the text checker for further processing
        let updatedSuggestions = processSuggestions(suggestedWords)
        
        // Update the word suggestions with the text checker's predictions
        wordSuggestion.updateSuggestions(updatedSuggestions)
    }
    
    private func processSuggestions(_ words: [String]) -> [String] {
        let rangeForEndOfStr = NSRange(location: 0, length: textEntry.currentText.utf16.count)
        let completions = textChecker.completions(forPartialWordRange: rangeForEndOfStr, in: textEntry.currentText, language: "en_US")
        return completions ?? []
    }
    
    // MARK: - Subscriptions
    
    private var cancellables = Set<AnyCancellable>()
    
    func subscribeToLatestTextEntryState() {
        textEntryStatePublisher
            .sink { [weak self] state in
                self?.handleLatestTextEntryState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleLatestTextEntryState(_ state: TextEntryState) {
        // Handle the latest text entry state here
        print(state)
        
        // Perform any necessary operations with the latest state
        let completions = getWordCompletions(for: state.text)
        let isSpellingCorrect = performSpellChecking(for: state.text)
        
        // Update the UI or perform other actions based on the latest state and results
        DispatchQueue.main.async {
            // Update the UI or trigger any necessary UI updates
            // For example:
            self.updateWordSuggestions(completions)
            self.updateSpellingIndicator(isSpellingCorrect)
        }
    }
    
    // MARK: - Word Completions
    
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    // MARK: - Spell Checking
    
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - Spelling Indicator Update
    
    private func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
   self.keyboardViewDelegateWrapper?.spellingIndicator = isSpellingCorrect
}

// MARK: - Word Suggestions Update

private func updateWordSuggestions(_ suggestions: [String]) {
   self.keyboardViewDelegateWrapper?.wordSuggestions = suggestions
}   
}

