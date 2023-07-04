import UIKit

class Settings {
    
    static let shared = Settings()
    
    // General Settings
    var isDarkModeEnabled: Bool = false
    var isAutoCapitalizationEnabled: Bool = true
    var isAutoCorrectionEnabled: Bool = true
    var isSmartQuotesEnabled: Bool = true
    
    // Keyboard Appearance Settings
    var keyboardBackgroundColor: UIColor = .white
    var keyColor: UIColor = .darkGray
    var keyCornerRadius: CGFloat = 8.0
    var keyTextFont: UIFont = UIFont.systemFont(ofSize: 18)
    var keyTextColor: UIColor = .black
    
    // Word Suggestion Settings
    var isWordSuggestionEnabled: Bool = true
    var wordSuggestionCount: Int = 3
    
    // Eye Tracking Settings
    var isEyeTrackingEnabled: Bool = true
    var eyeTrackingAccuracyThreshold: CGFloat = 0.8
    
    // Dynamic Calibration Settings
    var isDynamicCalibrationEnabled: Bool = true
    var dynamicCalibrationAnimationDuration: TimeInterval = 2.0
    
    // Swipe-to-Type Settings
    var isSwipeToTypeEnabled: Bool = true
    var swipeSensitivity: CGFloat = 0.5
    
    // Blink Gesture Settings
    var isBlinkGestureEnabled: Bool = true
    var blinkGestureDurationThreshold: TimeInterval = 0.3
    
    // Other Settings...
    
    private init() {}
}
