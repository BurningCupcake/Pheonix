import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings = false
    @State private var textInput = "" // State for the text input
    @ObservedObject private var settings = Settings.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Spacer at the top to push content to the center
                
                TextField("Enter text", text: $textInput) // Text input field
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Spacer() // Another spacer to ensure the TextField stays in the center
                
                
                // You can add other components here if needed
            }
            .padding()
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings.toggle()
            }) {
                Image(systemName: "gear") // Icon for settings, you can change this if you want
            })
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(settings: settings)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
