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
            .combineLatest(predictiveTextService.predictiveTextStatePublisher)
            .map { textEntryState, predictiveTextState in
                AppState(
                    textEntryState: textEntryState,
                    predictiveTextState: predictiveTextState
                )
            }
            .map { appState in
                appState.textEntryState
            }
            .sink { [weak self] textEntryState in
                self?.appState.textEntryState = textEntryState
            }
            .store(in: &cancellables)
    }
}

