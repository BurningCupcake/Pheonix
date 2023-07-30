import SwiftUI
import Combine

// A SwiftUI View for Keyboard
struct KeyboardView: View {
    // ObservedObject is a property wrapper type that subscribes to an ObservableObject.
    // It synthesizes a subscriber for any ObservableObject.
    @ObservedObject var delegateWrapper: KeyboardViewDelegateWrapper
    
    // Binding: A property wrapper type that can read and write a value owned by a source 
    // of truth.
    @Binding var wordSuggestions: [String]
    @Binding var spellingIndicator: Bool
    
    // The keyboard layout data
    let keyboardLayout: KeyboardLayout
    
    var body: some View {
        // Keyboard layout container
        VStack {
            // Keyboard title display
            Text("Keyboard View")
                .font(.title)
                .padding()
            
            // Displaying each key of the keyboard
            ForEach(Array(keyboardLayout.layout.enumerated()), id: \.offset) { rowIndex, row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        // Key press action
                        Button(action: {
                            delegateWrapper.didSelectKey(key)
                        }) {
                            // Key display
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
            
            // Displaying word suggestions
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
            
            // Displaying spelling check indicator
            Text(spellingIndicator ? "Correct" : "Incorrect")
                .font(.headline)
                .padding()
                .background(spellingIndicator ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}
