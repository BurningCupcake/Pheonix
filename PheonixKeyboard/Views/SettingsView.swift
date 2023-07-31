// Importing SwiftUI framework
import SwiftUI

// Defining a SettingsView struct that conforms to the View protocol
struct SettingsView: View {
    
    // Declaring an observable object to automatically refresh the UI when the settings change
    @ObservedObject var settings = Settings.shared
    
    var body: some View {
        
        // Form to contain the settings options
        Form {
            
            // General settings section
            Section(header: Text("General Settings")) {
                Toggle("Dark Mode", isOn: $settings.isDarkModeEnabled)
                Toggle("Auto Capitalization", isOn: $settings.isAutoCapitalizationEnabled)
                Toggle("Auto Correction", isOn: $settings.isAutoCorrectionEnabled)
                Toggle("Smart Quotes", isOn: $settings.isSmartQuotesEnabled)
            }
            
            // Word Suggestion settings section
            Section(header: Text("Word Suggestion Settings")) {
                Toggle("Word Suggestion", isOn: $settings.isWordSuggestionEnabled)
                Stepper("Word Suggestion Count: \(settings.wordSuggestionCount)", value: $settings.wordSuggestionCount, in: 1...10)
            }
            
            // Eye Tracking settings section
            Section(header: Text("Eye Tracking Settings")) {
                Toggle("Eye Tracking", isOn: $settings.isEyeTrackingEnabled)
                Slider(value: $settings.eyeTrackingAccuracyThreshold, in: 0.0...1.0) {
                    Text("Eye Tracking Accuracy Threshold")
                }
            }
            
            // Dynamic Calibration settings section
            Section(header: Text("Dynamic Calibration Settings")) {
                Toggle("Dynamic Calibration", isOn: $settings.isDynamicCalibrationEnabled)
                Slider(value: $settings.dynamicCalibrationAnimationDuration, in: 0.0...5.0) {
                    Text("Dynamic Calibration Animation Duration")
                }
            }
            
            // Swipe-to-Type settings section
            Section(header: Text("Swipe-to-Type Settings")) {
                Toggle("Swipe to Type", isOn: $settings.isSwipeToTypeEnabled)
                Slider(value: $settings.swipeSensitivity, in: 0.0...1.0) {
                    Text("Swipe Sensitivity")
                }
            }
            
            // Blink Gesture settings section
            Section(header: Text("Blink Gesture Settings")) {
                Toggle("Blink Gesture", isOn: $settings.isBlinkGesture)
                Slider(value: $settings.blinkGestureSensitivity, in: 0.0...1.0) { 
                    Text("Blink Gesture Sensitivity") 
                } 
            } 
        } 
     } 
 }
            
