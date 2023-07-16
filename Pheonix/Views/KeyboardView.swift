
import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var delegateWrapper: KeyboardViewDelegateWrapper
    @State private var wordSuggestions: [String] = []
    
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
        }
        .padding()
        .onReceive(delegateWrapper.objectWillChange) { _ in
            self.wordSuggestions = delegateWrapper.wordSuggestions
        }
    }
    
    func updateWordSuggestions(_ suggestions: [String]) {
        self.wordSuggestions = suggestions
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keyboardLayout: KeyboardLayout.defaultLayout())
            .environmentObject(KeyboardViewDelegateWrapper())
    }
}
