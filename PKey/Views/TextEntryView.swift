// Importing the SwiftUI module that provides the interface for building
// UI components.
import SwiftUI

// Creating a SwiftUI View named `TextEntryView`.
struct TextEntryView: View {
    // Declaring a variable `viewModel` of type `TextEntryViewModel`. 
    // This acts as the source of truth for the `TextEntryView` and updating 
    // viewModel will cause the view to re-render.
    @ObservedObject var viewModel: TextEntryViewModel
    
    // The declaration of the view hierarchy which will be displayed by SwiftUI.
    var body: some View {
        // A TextField view is returned which takes an initial placeholder text
        // "Enter text", and sets as its text binding to viewModel.textEntryState.text.
        // The TextField view updates this value as the user types.
        // The `onCommit` closure is called when the user presses the return 
        // key on the keyboard. It runs the `addCharacter` function of the `viewModel` 
        // passing the entered text as an argument.
        TextField("Enter text", text: $viewModel.textEntryState.text, onCommit: {
            let _ = viewModel.addCharacter(viewModel.textEntryState.text)
        })
    }
}
