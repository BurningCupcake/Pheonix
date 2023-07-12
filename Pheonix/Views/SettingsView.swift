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
                Slider("Eye Tracking Accuracy Threshold", value: $settings.eyeTrackingAccuracyThreshold, in: 0.0...1.0)
            }
            
            Section(header: Text("Dynamic Calibration Settings")) {
                Toggle("Dynamic Calibration", isOn: $settings.isDynamicCalibrationEnabled)
                Slider("Dynamic Calibration Animation Duration", value: $settings.dynamicCalibrationAnimationDuration, in: 0.0...5.0)
            }
            
            Section(header: Text("Swipe-to-Type Settings")) {
                Toggle("Swipe to Type", isOn: $settings.isSwipeToTypeEnabled)
                Slider("Swipe Sensitivity", value: $settings.swipeSensitivity, in: 0.0...1.0)
            }
            
            Section(header: Text("Blink Gesture Settings")) {
                Toggle("Blink Gesture", isOn: $settings.isBlinkGestureEnabled)
                Slider("Blink Gesture Duration Threshold", value: $settings.blinkGestureDurationThreshold, in: 0.0...1.0)
            }
            
            // Add more sections as needed
        }
    }
}
