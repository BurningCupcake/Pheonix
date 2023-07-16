//The PredictiveTextViewModel class is responsible for managing the predictive text state and interacting with the PredictiveTextService.

//Here's a breakdown of the key components:

//predictiveTextService: An instance of the PredictiveTextService class, which handles the logic for generating predictive text suggestions.
//cancellables: A set of AnyCancellable objects used to manage the lifetime of subscriptions.
//predictiveTextState: An @Published property that represents the current state of the predictive text suggestions. It's initially set to PredictiveTextState.empty, indicating no suggestions.
//init(predictiveTextService:): The initializer of the view model. It takes an instance of PredictiveTextService as a parameter and sets up a subscription to the predictiveTextStatePublisher of the service. Whenever a new state is received, it updates the predictiveTextState property, triggering the @Published property wrapper to notify the subscribers (such as views).
//updatePredictiveText(for:): A method used to update the predictive text based on the provided text. It calls the updatePredictiveText(for:) method of the PredictiveTextService, which performs the necessary calculations to generate new suggestions based on the given text.
//By using the PredictiveTextViewModel and its predictiveTextState property, you can observe and retrieve the current state of the predictive text suggestions in your SwiftUI views. The view model interacts with the PredictiveTextService to update the suggestions based on user input or any other relevant triggers.

import Foundation
import Combine

class PredictiveTextViewModel: ObservableObject {
    private let predictiveTextService: PredictiveTextService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var predictiveTextState: PredictiveTextState = PredictiveTextState.empty
    
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
