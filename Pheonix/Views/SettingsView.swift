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
