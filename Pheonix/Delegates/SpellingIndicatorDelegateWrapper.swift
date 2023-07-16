//
//  SpellingIndicatorDelegateWrapper.swift
//  Pheonix
//
//  Created by Justin Fortier on 7/15/23.
//

import Foundation

class SpellingIndicatorDelegateWrapper: ObservableObject {
    @Published var spellingIndicator: [String] = []
    
    func updateSpellingIndicator(_ isSpellingCorrect: Bool) {
        let indicator = isSpellingCorrect ? "✓" : "✕"
        self.spellingIndicator = [indicator]
    }
}
