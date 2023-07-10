import Foundation
import Combine

class KeyboardViewModel: ObservableObject {
    @Published var appState = AppState(
        textEntryState: TextEntryState(text: ""),
        predictiveTextState: PredictiveTextState(suggestions: [])
    )
    
    let textEntryService: TextEntryService
    let predictiveTextService: PredictiveTextService
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        textEntryService = TextEntryService()
        predictiveTextService = PredictiveTextService()
        
        textEntryService.textEntryStatePublisher
            .combineLatest(predictiveTextService.predictiveTextStatePublisher)
            .map { textEntryState, predictiveTextState in
                return AppState(
                    textEntryState: textEntryState,
                    predictiveTextState: predictiveTextState
                )
            }
            .sink { [weak self] appState in
                self?.appState = appState
            }
            .store(in: &cancellables)
    }
}
