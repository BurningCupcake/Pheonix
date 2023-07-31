import SwiftUI
import Combine

struct KeyboardView: View {
    @ObservedObject var delegateWrapper: KeyboardViewDelegateWrapper
    @Binding var wordSuggestions: [String]
    @Binding var spellingIndicator: Bool
    let keyboardLayout: KeyboardLayout
    
    var body: some View {
        VStack {
            Text("Keyboard View")
                .font(.title)
                .padding()
            ForEach(Array(keyboardLayout.layout.enumerated()), id: \.offset) { rowIndex, row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            delegateWrapper.didSelectKey(key, textEntryService: <#TextEntryService#>)
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
}
