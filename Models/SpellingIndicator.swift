// SpellingIndicator.swift

import Foundation
import Combine

// SpellingIndicator class that conforms to ObservableObject protocol for SwiftUI View updates
class SpellingIndicator: ObservableObject {
    
    // A boolean that indicates spelling correctness, published for use in SwiftUI
    @Published var isSpellingCorrect: Bool = true
    
    // Method that updates the `isSpellingCorrect` boolean with a new value
    func updateSpellingIndicator(_ spellingCorrectness: Bool) {
        isSpellingCorrect = spellingCorrectness
    }
}

