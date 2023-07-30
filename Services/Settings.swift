import UIKit

// This class manages application-wide settings.
class Settings {

    // Singleton shared instance.
    static let shared = Settings()

    // Boolean indicating whether the app's dark mode is enabled.
    var isDarkModeEnabled: Bool = false

    // Boolean indicating whether auto capitalization is enabled.
    var isAutoCapitalizationEnabled: Bool = true

    // Boolean indicating whether auto correction is enabled.
    var isAutoCorrectionEnabled: Bool = true

    // Boolean indicating whether smart quotes are enabled.
    var isSmartQuotesEnabled: Bool = true

    // The background color of the keyboard.
    var keyboardBackgroundColor: UIColor = .white

    // The color of the keys on the keyboard.
    var keyColor: UIColor = .darkGray

    // The corner radius of the keys on the keyboard.
    var keyCornerRadius: CGFloat = 8.0

    // The font of the text on the keyboard keys.
    var keyTextFont: UIFont = UIFont.systemFont(ofSize: 18)

    // The color of the text on the keyboard keys.
    var keyTextColor: UIColor = .black

    // Boolean indicating whether word suggestions are enabled.
    var isWordSuggestionEnabled: Bool = true

    // The maximum number of word suggestions to display.
    var wordSuggestionCount: Int = 3

    // Boolean indicating whether eye tracking is enabled.
    var isEyeTrackingEnabled: Bool = true

    // The minimum eye tracking accuracy threshold.
    var eyeTrackingAccuracyThreshold: CGFloat = 0.8

    // Boolean indicating whether dynamic calibration is enabled.
    var isDynamicCalibrationEnabled: Bool = true

    // The duration of the dynamic calibration animation.
    var dynamicCalibrationAnimationDuration: TimeInterval = 2.0

    // Boolean indicating whether swipe-to-type is enabled.
    var isSwipeToTypeEnabled: Bool = true

    // Sensitivity setting for swipe-to-type.
    var swipeSensitivity: CGFloat = 0.5

    // Boolean indicating whether blink gesture control is enabled.
    var isBlinkGestureEnabled: Bool = true

    // The blink gesture duration threshold.
    var blinkGestureDurationThreshold: TimeInterval = 0.3

    // Ensuring that the settings class cannot be instantiated from outside.
    private init() {}
}
