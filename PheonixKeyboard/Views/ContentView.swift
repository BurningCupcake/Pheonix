import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings = false
    @ObservedObject private var settings = Settings.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                
                // Here you can add other components of your ContentView
                
                Button("Settings") {
                    isShowingSettings.toggle()
                }
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView(settings: settings)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
