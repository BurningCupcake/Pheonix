import SwiftUI

struct TextEntryView: View {
    @ObservedObject var viewModel: TextEntryViewModel
    
    var body: some View {
        TextField("Enter text", text: $viewModel.textEntryState.text, onCommit: {
            let _ = viewModel.addCharacter("")
        })
    }
}
