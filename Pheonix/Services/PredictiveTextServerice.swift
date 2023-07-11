import Foundation
import Combine


class PredictiveTextService {
    private let predictiveTextStateSubject = CurrentValueSubject<PredictiveTextState, Never>(.empty)
    
    var predictiveTextStatePublisher: AnyPublisher<PredictiveTextState, Never> {
        return predictiveTextStateSubject.eraseToAnyPublisher()
    }
    
    func updatePredictiveText(for text: String) {
        // Update predictive text state
        // ...
        
        predictiveTextStateSubject.send(predictiveTextState)
    }
}

struct PredictiveTextState: Equatable {
    var suggestions: [String]
    
    static let empty = PredictiveTextState(suggestions: [])
}
