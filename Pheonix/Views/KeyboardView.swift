import SwiftUI
import Combine

struct KeyboardView: View {
    @EnvironmentObject var delegateWrapper: KeyboardViewDelegateWrapper
    @State private var wordSuggestions: [String] = []
    @State private var spellingIndicator: Bool = true
    
    let keyboardLayout: KeyboardLayout
    
    var body: some View {
        VStack {
            Text("Keyboard View")
                .font(.title)
                .padding()
            
            // Add keys based on the keyboard layout
            ForEach(0..<keyboardLayout.layout.count, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<keyboardLayout.layout[rowIndex].count, id: \.self) { columnIndex in
                        let key = keyboardLayout.layout[rowIndex][columnIndex]
                        
                        Button(action: {
                            delegateWrapper.didSelectKey(key)
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
            
            // Word suggestions
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
            
            // Spelling Indicator
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
        .onReceive(delegateWrapper.$spellingIndicator) { indicator in
            self.spellingIndicator = indicator
        }
    }
}
