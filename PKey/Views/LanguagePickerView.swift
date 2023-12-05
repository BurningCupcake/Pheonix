import SwiftUI

struct LanguagePickerView: View {
    @Binding var selectedLanguage: String
    
    var body: some View {
        Picker("Language", selection: $selectedLanguage) {
            Text("English").tag("English")
            Text("Spanish").tag("Spanish")
            Text("Chinese").tag("Chinese")
            Text("French").tag("French")
            Text("German").tag("German")
            Text("Italian").tag("Italian")
            Text("Japanese").tag("Japanese")
            Text("Portuguese").tag("Portuguese")
            Text("Russian").tag("Russian")
            Text("Hindi").tag("Hindi")
            Text("Arabic").tag("Arabic")
            Text("Korean").tag("Korean")
        }
    }
}
