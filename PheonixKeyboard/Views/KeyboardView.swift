import SwiftUI
import Combine

struct KeyboardView: View {
    @ObservedObject var delegateWrapper: KeyboardViewDelegateWrapper
    @Binding var text: String // Binding for the text
    @Binding var wordSuggestions: [String]
    @Binding var spellingIndicator: Bool
    let keyboardLayout: KeyboardLayout
    
    var textEntryService: TextEntryService
    
    var body: some View {
        VStack {
            Text(text) // Display the text
                .font(.title)
                .padding()
            ForEach(Array(keyboardLayout.layout.enumerated()), id: \.offset) { rowIndex, row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            // Use the instance of TextEntryService here
                            delegateWrapper.didSelectKey(key, textEntryService: textEntryService)
                        }) {
                            Text(key)
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            HStack {
                ForEach(delegateWrapper.wordSuggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .font(.headline)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            Text(spellingIndicator ? "Correct" : "Incorrect")
                .font(.headline)
                .padding()
                .background(spellingIndicator ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
    // Method to update text
    func updateText(_ newText: String) {
        _text.wrappedValue = newText
    }
    
    // Method to update word suggestions
    func updateWordSuggestions(_ newSuggestions: [String]) {
        _wordSuggestions.wrappedValue = newSuggestions
    }
    
    // Method to update spelling indicator
    func updateSpellingIndicator(_ isCorrect: Bool) {
        _spellingIndicator.wrappedValue = isCorrect
    }
}

