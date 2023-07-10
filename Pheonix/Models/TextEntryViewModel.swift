import Foundation
import Combine

class TextEntryViewModel: ObservableObject {
    private let textEntryService: TextEntryService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var textEntryState: TextEntryState = .empty
    
    init(textEntryService: TextEntryService) {
        self.textEntryService = textEntryService
        
        textEntryService.textEntryStatePublisher
            .sink { [weak self] state in
                self?.textEntryState = state
            }
            .store(in: &cancellables)
    }
    
    func addCharacter(_ character: String) -> Result<TextEntryState, TextEntryError> {
        return textEntryService.addCharacter(character)
    }
}

struct TextEntryState: Equatable {
    var text: String
    
    static let empty = TextEntryState(text: "")
}
