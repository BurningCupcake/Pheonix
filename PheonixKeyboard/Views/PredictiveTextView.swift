// Importing SwiftUI framework
import SwiftUI

// Defining a new view called PredictiveTextView.
struct PredictiveTextView: View {
    // Using ObservableObject to monitor changes in an instance of PredictiveTextViewModel
    @ObservedObject var viewModel: PredictiveTextViewModel
    
    // SwiftUI calls `var body: some View` to build the view’s content.
    // This computed property should return some sort of view that SwiftUI can display.
    var body: some View {
        // Build a list 
        List {
            // Use ForEach to loop through all elements in predictiveTextState's suggestions list 
            // This list is part of the ViewModel instance and it contains the suggested texts.
            ForEach(viewModel.predictiveTextState.suggestions, id: \.self) { suggestion in
                // For each suggestion in the list, we create a Text view
                Text(suggestion)
            }
        }
    }
}
