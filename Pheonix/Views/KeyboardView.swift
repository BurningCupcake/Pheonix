//This file defines the SwiftUI view responsible for rendering the keyboard interface. Here's a breakdown of its implementation:

//The KeyboardView struct is declared, conforming to the View protocol in SwiftUI.
//It contains the following properties:
//delegateWrapper: An EnvironmentObject that holds the KeyboardViewDelegateWrapper, allowing access to the delegate methods.
//wordSuggestions: A state property to hold the word suggestions displayed on the keyboard view.
//keyboardLayout: The layout configuration for the keyboard.
//The body property defines the view hierarchy using a VStack as the root container.
//Within the VStack, the view displays a "Keyboard View" title using a Text view with appropriate styling.
//The keyboard keys are generated dynamically based on the provided keyboardLayout. Nested ForEach loops iterate over the rows and columns of the layout, creating buttons for each key. When a key is tapped, the corresponding action is triggered by calling delegateWrapper.didSelectKey(_:).
//Below the keyboard keys, there is a section for displaying word suggestions. A horizontal stack (HStack) is used to display the suggestions in a row. Each suggestion is represented by a Text view with appropriate styling.
//The onReceive modifier is used to observe changes in the delegateWrapper. When the delegate updates its wordSuggestions property, the wordSuggestions state of the view is updated accordingly.
//The updateWordSuggestions(_:) function allows updating the word suggestions externally.
//Lastly, the KeyboardView struct is previewed with a default layout using the KeyboardLayout.defaultLayout() initializer.
//Overall, this file defines the SwiftUI view for the keyboard interface, including the keys and word suggestions. It interacts with the delegate wrapper to handle key selection and display the updated word suggestions on the keyboard view.

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
                            delegateWrapper.didSelectKey(key, textEntryService: delegateWrapper.textEntryService)
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
