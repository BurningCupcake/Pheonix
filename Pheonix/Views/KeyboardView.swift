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
            
            ForEach(Array(keyboardLayout.layout.enumerated()), id: \.1) { rowIndex, row in
                HStack {
                    ForEach(Array(row.enumerated()), id: \.1) { columnIndex, key in
                        Button(action: {
                            delegateWrapper.delegate?.didSelectKey(key)
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
                ForEach(wordSuggestions, id: \.self) { suggestion in
                    Text(suggestion)
                        .font(.headline)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            Text("Spelling Indicator: \(spellingIndicator ? "Correct" : "Incorrect")")
                .font(.headline)
                .padding()
                .background(spellingIndicator ? Color.green : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("DelegateWrapperDidChange"))) { _ in
            self.wordSuggestions = delegateWrapper.wordSuggestions
        }
        .onReceive(Just(delegateWrapper.spellingIndicator)) { indicator in
            self.spellingIndicator = indicator
        }
    }
}
