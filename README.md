# Pheonix Keyboard

Pheonix is a custom keyboard for iOS that utilizes gaze detection and eye tracking technology for text entry. It provides an alternative input method for users with limited mobility or disabilities. The keyboard supports features such as predictive text, dynamic calibration, swipe-to-type, and blink gestures.

## Features

- **Gaze Detection**: The keyboard tracks the user's eye movements to determine the intended key selection.
- **Eye Tracking**: Utilizes ARKit and face tracking to precisely track the user's gaze and convert it into text input.
- **Predictive Text**: Provides word suggestions based on the user's input to enhance typing speed and accuracy.
- **Dynamic Calibration**: Enables the user to perform calibration for improved accuracy and responsiveness.
- **Swipe-to-Type**: Allows users to swipe across keys to form words without lifting their finger.
- **Blink Gestures**: Recognizes blinks as gestures for specific actions, such as space or delete.

## File Structure

The Pheonix keyboard project consists of the following components:

- **Controllers**: Contains the main view controller classes, including the keyboard view controller, eye tracking controller, and swipe-to-type controller.
- **Views**: Contains the SwiftUI view implementations for the keyboard, calibration, text entry, predictive text, and other visual elements.
- **Models**: Contains the data models and view models used by the keyboard, including the app state, keyboard keys, eye state, calibration result, and keyboard layout.
- **Services**: Contains the service classes responsible for keyboard interaction, text entry, gaze detection, word suggestion, dynamic calibration, and other related functionalities.
- **Delegates**: Contains the delegate protocols used for communication between different components, including the keyboard view delegate, eye tracker delegate, calibration delegate, word suggestion delegate, and more.
- **Resources**: Contains the XIB file for the keyboard interface.
- **Supporting Files**: Contains supporting files and assets used by the keyboard.

Pheonix tree new****

|____Pheonix
| |____.DS_Store
| |____Resources
| | |____Keyboard.xib
| |____Models
| | |____AppState.swift
| | |____KeyboardKey.swift
| | |____Language.swift
| | |____EyeState.swift
| | |____PredictiveTextViewModel.swift
| | |____TextEntryViewModel.swift
| | |____Key.swift
| | |____KeyboardViewModel.swift
| | |____DynamicCalibrationModel.swift
| | |____CalibrationResult.swift
| | |____KeyboardLayoutStyle.swift
| | |____KeyboardLayout.swift
| |____Preview Content
| | |____Preview Assets.xcassets
| | | |____Contents.json
| |____Supporting Files
| | |____Assets.xcassets
| | | |____AppIcon.appiconset
| | | | |____IMG_6989.jpg
| | | | |____Contents.json
| | | |____AccentColor.colorset
| | | | |____Contents.json
| | | |____Contents.json
| |____Delegates
| | |____KeyboardViewDelegateWrapper.swift
| | |____EyeTrackerDelegate.swift
| | |____CalibrationDelegate.swift
| | |____WordSuggestionDelegate.swift
| | |____WordSuggestionDelegateWrapper.swift
| | |____BlinkGestureHandlerDelegate.swift
| | |____GazeCalibrationDeligate.swift
| | |____KeyboardViewDelegate.swift
| | |____KeyboardInteractionDelegate.swift
| | |____GazeDetectionDelegate.swift
| | |____GestureRecognitionDelegate.swift
| | |____SceneDelegate.swift
| | |____SwipeToTypeControllerDelegate.swift
| |____Controllers
| | |____EyeTrackingController.swift
| | |____KeyboardViewController.swift
| | |____SwipeToTypeController.swift
| | |____EyeGazeViewController.swift
| | |____AppDelegate.swift
| |____Views
| | |____CalibrationView.swift
| | |____KeyboardKey.swift
| | |____CalibrationProgressView.swift
| | |____PredictiveTextView.swift
| | |____SettingsView.swift
| | |____DynamicCalibrationView.swift
| | |____TextEntryView.swift
| | |____KeyboardView.swift
| | |____LanguagePickerView.swift
| | |____SwipeToTypeView.swift
| | |____ContentView.swift
|____Services
| |____DynamicCalibration.swift
| |____WordSuggestion.swift
| |____KeyboardInteraction.swift
| |____DependencyInjection.swift
| |____TextEntry.swift
| |____GestureRecognition.swift
| |____GazeDetection.swift
| |____Settings.swift
| |____EyeTracker.swift
| |____PredictiveTextService.swift
| |____TextEntryService.swift
| |____BlinkGestureHandler.swift
|____Keyboard.swift

## Getting Started

To use the Pheonix keyboard in your iOS project, follow these steps:

1. Add the Pheonix project to your Xcode workspace or include the necessary source files in your project.
2. Configure the necessary dependencies and services using the `DependencyInjection` class. This class provides singleton instances of the required dependencies.
3. Customize the keyboard appearance, settings, and other configurations in the `Settings` class. Modify the properties in this class to suit your desired keyboard style and behavior.
4. Integrate the keyboard view controller into your app's view hierarchy by instantiating it and presenting it when needed. You can use the `KeyboardViewController` class provided in the project.
5. Implement the necessary delegate methods to handle text input and other interactions:
   - Conform to the `KeyboardViewDelegate` protocol to receive notifications when keys are selected or when word suggestions are updated.
   - Conform to the `EyeTrackerDelegate` protocol to receive gaze tracking updates from the eye tracker.
   - Conform to the `CalibrationDelegate` protocol to handle calibration progress and completion.
   - Conform to the `WordSuggestionDelegate` protocol to receive word suggestions based on the user's input.
   - Conform to the `SwipeToTypeControllerDelegate` protocol to handle swipe gestures for text input.
6. Optionally, customize the keyboard layout, gestures, or add additional features as per your requirements. Modify the `KeyboardLayout` class and related components to define your desired keyboard layout and key configuration.

## Requirements

- iOS 13.0 or later
- Xcode 12.0 or later
- Swift 5.0 or later

## License

The Pheonix keyboard project is licensed under the [MIT License](LICENSE).

## Acknowledgements

The Pheonix keyboard project utilizes various open-source libraries and frameworks. Special thanks to the contributors of these projects for their valuable work.

- [ARKit](https://developer.apple.com/documentation/arkit): Apple's augmented reality framework used for eye tracking.
- [Combine](https://developer.apple.com/documentation/combine): Apple's reactive programming framework used for data flow and event handling.
- [UIKit](https://developer.apple.com/documentation/uikit): Apple's user interface framework used for the keyboard interface.
- [SwiftUI](https://developer.apple.com/documentation/swiftui): Apple's declarative user interface framework used for building the keyboard views.

## Contributing

Contributions to the Pheonix keyboard project are welcome! If you have any suggestions, improvements, or bug fixes, please open an issue or submit a pull request.

---

This README provides an overview of the Pheonix keyboard and its file structure. For detailed implementation details and code, refer to the individual files in the project.

For further assistance or questions, feel free to reach out.
