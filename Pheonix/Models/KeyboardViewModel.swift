import Foundation
import Combine

class KeyboardViewModel: ObservableObject {
    @Published var appState = AppState(
        textEntryState: .empty,
        predictiveTextState: .empty
    )
    
    let textEntryService: TextEntryService
    let predictiveTextService: PredictiveTextService
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        textEntryService = TextEntryService()
        predictiveTextService = PredictiveTextService()
        
        textEntryService.textEntryStatePublisher
            .combineLatest(predictiveTextService.predictiveTextStatePublisher)
            .map { AppState(textEntryState: $0, predictiveTextState: $1) }
            .sink { [weak self] appState in
                self?.appState = appState
            }
            .store(in: &cancellables)
    }
}
