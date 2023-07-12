import Foundation

protocol KeyboardViewDelegate: AnyObject {
    func didSelectKey(_ key: String, textEntryService: TextEntryService)
    func updateWordSuggestions(_ suggestions: [String])
}

extension KeyboardViewDelegate {
    func didSelectKey(_ key: String, textEntryService: TextEntryService) {
        if key.count == 1 && key.rangeOfCharacter(from: CharacterSet.letters) != nil {
            let result = textEntryService.addCharacter(key)
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                case .failure(let error):
                    print("Error adding character: \(error)")
            }
        } else if key == " " {
            let result = textEntryService.addCharacter(" ")
            switch result {
                case .success(let state):
                    print("New state: \(state)")
                case .failure(let error):
                    print("Error adding space: \(error)")
            }
        } else if key == "<" {
            textEntryService.deleteLastCharacter()
        }
        // Add other cases as necessary
    }
}
