import SwiftUI

struct PredictiveTextView: View {
    @ObservedObject var viewModel: PredictiveTextViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.predictiveTextState.suggestions, id: \.self) { suggestion in
                Text(suggestion)
            }
        }
    }
}
