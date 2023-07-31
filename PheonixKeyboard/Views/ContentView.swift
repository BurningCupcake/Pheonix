import SwiftUI

// ContentView is the main struct that handles all the components in the SwiftUI project.
struct ContentView: View {
    // The following variables hold the state of the various view components and settings.
    @State private var text = ""
    @State private var isShowingDynamicCalibration = false
    @State private var isShowingSettings = false
    @State private var isShowingSwipeToType = false
    @State private var keyboardLayoutStyle = KeyboardLayoutStyle.english
    @State private var currentSuggestions: [String] = []
    @State private var language = Language.english
    @State private var isPredictiveTextEnabled = false
    @State private var isSwipeToTypeEnabled = false
    @State private var isDynamicCalibrationEnabled = false
    @State private var isEyeTrackingEnabled = false
    @State private var isBlinkingEnabled = false
    @State private var isKeyboardEnabled = true
    @State private var isSettingsEnabled = false
    @State private var isSwipeToTypeControllerEnabled = false
    @State private var isDynamicCalibrationViewEnabled = false
    @State private var isKeyboardViewEnabled = false
    @State private var isLanguagePickerEnabled = false
    @State private var isPredictiveTextEnabledOnKeyboard = false
    @State private var isSwipeToTypeEnabledOnKeyboard = false
    @State private var isDynamicCalibrationEnabledOnKeyboard = false
    @State private var isEyeTrackingEnabledOnKeyboard = false
    @State private var isBlinkingEnabledOnKeyboard = false
    
    
    // This defines the content's view structure and logic
    var body: some View {
        NavigationView {
            VStack {
                // An image of a globe
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                
                // The keyboard component
                KeyboardView(layoutStyle: keyboardLayoutStyle)
                
                // Toggle button for enabling/disabling settings.
                Button(action: {
                    self.isShowingSettings.toggle()
                }) {
                    Text("Settings")
                }
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView(isPredictiveTextEnabled: self.$isPredictiveTextEnabled,
                                 isSwipeToTypeEnabled: self.$isSwipeToTypeEnabled,
                                 isDynamicCalibrationEnabled: self.$isDynamicCalibrationEnabled,
                                 keyboardLayoutStyle: self.$keyboardLayoutStyle,
                                 language: self.$language)
                }
            }
            .padding() // Add padding for all elements inside VStack
        }
    }
}


// ContentView_Previews is responsible for producing preview content
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
