import SwiftUI

class KeyboardViewDelegateWrapper: ObservableObject, KeyboardViewDelegate {
    @Published var wordSuggestions: [String] = []
    
    func didSelectKey(_ key: String) {
        // Handle key selection event
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        wordSuggestions = suggestions
    }
}

struct KeyboardView: View {
    var keyboardInteraction: KeyboardInteraction
    @StateObject var delegateWrapper = KeyboardViewDelegateWrapper()
    
    var keyboardLayout: KeyboardLayout = KeyboardLayout.defaultLayout()
    
    var body: some View {
        VStack {
            Text("Keyboard View")
                .font(.title)
                .padding()
            
            // Add keys based on the keyboard layout and interaction
            ForEach(keyboardLayout.layout.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(keyboardLayout.layout[rowIndex].indices, id: \.self) { columnIndex in
                        Text(keyboardLayout.layout[rowIndex][columnIndex])
                            .tag(rowIndex * keyboardLayout.layout[rowIndex].count + columnIndex)
                            .onTapGesture {
                                let key = keyboardLayout.layout[rowIndex][columnIndex]
                                delegateWrapper.didSelectKey(key)
                            }
                    }
                }
            }
        }
        .onAppear {
            delegateWrapper.updateWordSuggestions([])
        }
        .environmentObject(delegateWrapper)
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        delegateWrapper.updateWordSuggestions(suggestions)
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keyboardInteraction: KeyboardInteraction(layout: KeyboardLayout.defaultLayout()))
    }
}
