import Foundation
import Combine

class PredictiveTextViewModel: ObservableObject {
    private let predictiveTextService: PredictiveTextService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var predictiveTextState: PredictiveTextState = .empty
    
    init(predictiveTextService: PredictiveTextService) {
        self.predictiveTextService = predictiveTextService
        
        predictiveTextService.predictiveTextStatePublisher
            .sink { [weak self] state in
                self?.predictiveTextState = state
            }
            .store(in: &cancellables)
    }
    
    func updatePredictiveText(for text: String) {
        predictiveTextService.updatePredictiveText(for: text)
    }
}
