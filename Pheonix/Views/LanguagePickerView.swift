import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    
    var body: some View {
        Picker("Language", selection: $selectedLanguage) {
            Text("English").tag("English")
            Text("Spanish").tag("Spanish")
            // Add more languages here
        }
    }
}
