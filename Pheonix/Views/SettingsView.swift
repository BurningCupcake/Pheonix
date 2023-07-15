//This file defines a SwiftUI view called SettingsView that displays various settings options in a Form layout. Let's break down the implementation:

//The SettingsView struct is declared, conforming to the View protocol in SwiftUI.
//It contains a single property:
//settings: A @State property that holds an instance of the Settings class, which manages the application's settings.
//The body property describes the view's content using a Form component.
//Inside the Form, there are several Section components that group related settings options together.
//Each Section has a header text indicating the category of settings.
//Within each Section, there are various Toggle and Slider components that represent individual settings options.
//The Toggle components are used for boolean settings, allowing the user to enable or disable a particular feature.
//The Slider components are used for settings that require a range of values, such as sensitivity or duration thresholds.
//The values of the settings are bound to the corresponding properties in the Settings class using the $ prefix to create a two-way binding.
//Each setting is labeled with a descriptive text using the Text view.
//The view uses @State to track changes to the settings and update the view accordingly.
//Overall, this file defines a SwiftUI view that presents a user interface for configuring various application settings in a structured and intuitive manner.

import SwiftUI

struct SettingsView: View {
    @State private var settings = Settings.shared
    
    var body: some View {
        Form {
            Section(header: Text("General Settings")) {
                Toggle("Dark Mode", isOn: $settings.isDarkModeEnabled)
                Toggle("Auto Capitalization", isOn: $settings.isAutoCapitalizationEnabled)
                Toggle("Auto Correction", isOn: $settings.isAutoCorrectionEnabled)
                Toggle("Smart Quotes", isOn: $settings.isSmartQuotesEnabled)
            }
            
            Section(header: Text("Word Suggestion Settings")) {
                Toggle("Word Suggestion", isOn: $settings.isWordSuggestionEnabled)
                Stepper("Word Suggestion Count: \(settings.wordSuggestionCount)", value: $settings.wordSuggestionCount, in: 1...10)
            }
            
            Section(header: Text("Eye Tracking Settings")) {
                Toggle("Eye Tracking", isOn: $settings.isEyeTrackingEnabled)
                Slider(value: $settings.eyeTrackingAccuracyThreshold, in: 0.0...1.0) {
                    Text("Eye Tracking Accuracy Threshold")
                }
            }
            
            Section(header: Text("Dynamic Calibration Settings")) {
                Toggle("Dynamic Calibration", isOn: $settings.isDynamicCalibrationEnabled)
                Slider(value: $settings.dynamicCalibrationAnimationDuration, in: 0.0...5.0) {
                    Text("Dynamic Calibration Animation Duration")
                }
            }
            
            Section(header: Text("Swipe-to-Type Settings")) {
                Toggle("Swipe to Type", isOn: $settings.isSwipeToTypeEnabled)
                Slider(value: $settings.swipeSensitivity, in: 0.0...1.0) {
                    Text("Swipe Sensitivity")
                }
            }
            
            Section(header: Text("Blink Gesture Settings")) {
                Toggle("Blink Gesture", isOn: $settings.isBlinkGestureEnabled)
                Slider(value: $settings.blinkGestureDurationThreshold, in: 0.0...1.0) {
                    Text("Blink Gesture Duration Threshold")
                }
            }
            
            // Add more sections as needed
        }
    }
}
