import Foundation
import Combine

// PredictiveTextViewModel is a class that is used to bind the PredictiveTextState updatable data to the View. 
class PredictiveTextViewModel: ObservableObject {
    // An instance of the class/service that provides the text prediction capability.
    private let predictiveTextService: PredictiveTextService
    // A collection of AnyCancellable instances that the PredictiveTextService instance produces.
    private var cancellables = Set<AnyCancellable>()
    
    // Published property to propagate changes to the predictive text state to subscribed views.
    @Published var predictiveTextState: PredictiveTextState = PredictiveTextState.empty
    
    // Constructor initializer accepting an instance of PredictiveTextService.
    init(predictiveTextService: PredictiveTextService) {
        self.predictiveTextService = predictiveTextService
        
        // Subscribes and stores the subscriber to changes in the PredictiveTextService's PredictiveTextState for object updates.
        predictiveTextService.predictiveTextStatePublisher
            .sink { [weak self] state in
                // Update the predictive text state whenever it changes in the PredictiveTextService.
                self?.predictiveTextState = state
            }
            .store(in: &cancellables) // Stores the AnyCancellable instance for potential cancellation later.
    }
    
    // Method that updates the predictive text based on the input text.
    func updatePredictiveText(for text: String) {
        predictiveTextService.updatePredictiveText(for: text)
    }
}
