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
            .sink { [weak self] textEntryState in
                self?.appState = AppState(
                    textEntryState: textEntryState,
                    predictiveTextState: self?.appState.predictiveTextState ?? initialPredictiveTextState
                )
            }
            .store(in: &cancellables)
    }
}
