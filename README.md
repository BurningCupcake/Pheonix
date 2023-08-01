Absolutely, here's a more detailed version of the README:

---

# Pheonix

Pheonix is an innovative keyboard application designed to be controlled using eye movements. The application uses advanced eye tracking technology to allow users to type without the need for physical interaction with the keyboard.

## Architecture

Pheonix is built using Swift and leverages the power of Apple's ARKit for eye tracking. The application is divided into several components, each responsible for a specific functionality:

- **Models**: This component contains the data models used throughout the application. These include models for managing the application state, keyboard layout, text entry, eye movement monitoring, and more.

- **Services**: This component contains the services that provide core functionalities such as eye tracking, gaze detection, text entry, dynamic calibration, and word suggestion.

- **Views**: This component contains the SwiftUI views that make up the user interface of the application. These include views for the keyboard, settings, and various other UI elements.

- **Controllers**: This component contains the controllers that manage the interaction between the models and views.

## Features

### Eye Tracking

Pheonix uses advanced eye tracking technology to track the user's gaze and determine which key they are looking at. The application can handle both continuous and discrete eye movements. The eye tracking functionality is provided by the `EyeTracker` service, which uses ARKit's face tracking capabilities to track the user's gaze.

### Dynamic Calibration

The application includes a dynamic calibration process that adjusts the eye tracking system to the individual user's eye movements. This ensures accurate and reliable gaze tracking. The dynamic calibration functionality is provided by the `DynamicCalibration` service, which uses a fractal-based approach to calibrate the eye tracking system.

### Predictive Text

Pheonix includes a predictive text system that suggests words based on the user's input. This feature can significantly speed up the typing process. The predictive text functionality is provided by the `PredictiveTextService`, which uses a language model to generate word predictions.

### Word Suggestions

The application provides word suggestions based on the current text. This feature can help users type faster and with fewer errors. The word suggestion functionality is provided by the `WordSuggestion` service, which uses a language model to generate word suggestions.

### Customizable Settings

Users can customize various settings, such as the keyboard layout, eye tracking accuracy threshold, dynamic calibration settings, and more. The settings functionality is provided by the `Settings` singleton, which manages the application-wide settings.

## Usage

To use Pheonix, simply look at the key you want to type. The application will track your gaze and select the key you are looking at. To type a key, simply blink or perform another predefined action.

## Installation

Pheonix is currently under development and is not yet available for installation. Please check back later for updates.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

Pheonix is licensed under the MIT License. See `LICENSE` for more information.

---

Current Complete File Tree of source codebase.

|____.DS_Store
|____PheonixUITests
| |____KeyboardUITests.swift
|____Pheonix.xcodeproj
| |____project.pbxproj
| |____xcuserdata
| | |____justinfortier.xcuserdatad
| | | |____xcdebugger
| | | | |____Breakpoints_v2.xcbkptlist
| | | |____xcschemes
| | | | |____xcschememanagement.plist
| |____project.xcworkspace
| | |____contents.xcworkspacedata
| | |____xcuserdata
| | | |____justinfortier.xcuserdatad
| | | | |____IDEFindNavigatorScopes.plist
| | | | |____WorkspaceSettings.xcsettings
| | | | |____UserInterfaceState.xcuserstate
| | |____xcshareddata
| | | |____IDEWorkspaceChecks.plist
| | | |____WorkspaceSettings.xcsettings
| | | |____swiftpm
| | | | |____configuration
| |____xcshareddata
| | |____xcschemes
| | | |____PheonixKeyboard.xcscheme
| | | |____Pheonix.xcscheme
|____Models
| |____AppState.swift
| |____FractalState.swift
| |____KeyboardKey.swift
| |____Language.swift
| |____EyeState.swift
| |____.DS_Store
| |____SwipeDirection.swift
| |____EyeMovements.swift
| |____PredictiveTextViewModel.swift
| |____TextEntryViewModel.swift
| |____Key.swift
| |____SpellingIndicator.swift
| |____KeyboardViewModel.swift
| |____TextEntryError.swift
| |____DynamicCalibrationModel.swift
| |____CalibrationResult.swift
| |____EyeMovementMonitor.swift
| |____KeyboardLayoutStyle.swift
| |____KeyboardLayout.swift
|____README.md
|____TestPlan.xctestplan
|____Pheonix
| |____.DS_Store
| |____Resources
| | |____Keyboard.xib
| | |____IMG_6989.jpg
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
| |____info.plist
|____AppDelegate.swift
|____.git
| |____.DS_Store
| |____ORIG_HEAD
| |____config
| |____objects
| |____HEAD
| |____info
| | |____exclude
| |____logs
| | |____HEAD
| | |____refs
| | | |____heads
| | | | |____0.7.1
| | | | |____0.5.2
| | | | |____0.3.1
| | | | |____revert-1-0.4.1
| | | | |____0.4.1
| | | | |____0.7.2
| | | | |____0.5.1
| | | | |____0.5.0
| | | | |____0.3.2
| | | | |____main
| | | | |____0.4.2
| | | | |____0.6.1
| | | | |____0.6.0
| | | |____remotes
| | | | |____origin
| | | | | |____0.7.1
| | | | | |____0.5.2
| | | | | |____0.3.1
| | | | | |____revert-1-0.4.1
| | | | | |____0.4.1
| | | | | |____HEAD
| | | | | |____0.7.2
| | | | | |____0.5.1
| | | | | |____0.5.0
| | | | | |____0.3.2
| | | | | |____main
| | | | | |____0.4.2
| | | | | |____0.6.1
| | | | | |____0.6.0
| | | |____stash
| |____description
| |____hooks
| | |____README.sample
| | |____commit-msg.sample
| | |____pre-rebase.sample
| | |____pre-commit.sample
| | |____applypatch-msg.sample
| | |____fsmonitor-watchman.sample
| | |____pre-receive.sample
| | |____prepare-commit-msg.sample
| | |____post-update.sample
| | |____pre-merge-commit.sample
| | |____pre-applypatch.sample
| | |____pre-push.sample
| | |____update.sample
| | |____push-to-checkout.sample
| |____refs
| | |____heads
| | | |____0.7.1
| | | |____0.5.2
| | | |____0.3.1
| | | |____revert-1-0.4.1
| | | |____0.4.1
| | | |____0.7.2
| | | |____0.5.1
| | | |____0.5.0
| | | |____0.3.2
| | | |____main
| | | |____0.4.2
| | | |____0.6.1
| | | |____0.6.0
| | |____tags
| | |____remotes
| | | |____origin
| | | | |____0.7.1
| | | | |____0.5.2
| | | | |____0.3.1
| | | | |____revert-1-0.4.1
| | | | |____0.4.1
| | | | |____HEAD
| | | | |____0.7.2
| | | | |____0.5.1
| | | | |____0.5.0
| | | | |____0.3.2
| | | | |____main
| | | | |____0.4.2
| | | | |____0.6.1
| | | | |____0.6.0
| | |____stash
| |____index
| |____COMMIT_EDITMSG
| |____FETCH_HEAD
|____PheonixKeyboard
| |____.DS_Store
| |____Delegates
| | |____KeyboardViewDelegateWrapper.swift
| | |____EyeTrackerDelegate.swift
| | |____CalibrationDelegate.swift
| | |____WordSuggestionDelegate.swift
| | |____.DS_Store
| | |____BlinkGestureHandlerDelegate.swift
| | |____GazeCalibrationDeligate.swift
| | |____TextEntryDelegate.swift
| | |____SpellingIndicatorDelegateWrapper.swift
| | |____KeyboardViewDelegate.swift
| | |____KeyboardInteractionDelegate.swift
| | |____GazeDetectionDelegate.swift
| | |____GestureRecognitionDelegate.swift
| | |____DynamicCalibrationDelegate.swift
| | |____WordSugestionDelegateWrapper.swift
| | |____SwipeToTypeControllerDelegate.swift
| |____Controllers
| | |____.DS_Store
| | |____EyeTrackingController.swift
| | |____KeyboardViewController.swift
| | |____SwipeToTypeController.swift
| | |____EyeGazeViewController.swift
| |____Views
| | |____CalibrationProgressView.swift
| | |____PredictiveTextView.swift
| | |____SettingsView.swift
| | |____.DS_Store
| | |____DynamicCalibrationView.swift
| | |____TextEntryView.swift
| | |____KeyboardView.swift
| | |____Keyboard.swift
| | |____LanguagePickerView.swift
| | |____SwipeToTypeView.swift
| | |____ContentView.swift
| |____Info.plist
|____Iphone.mobileprovision
|____main.swift
|____PheonixTests
| |____EyeTrackerTests.swift
| |____TextEntryTests.swift
| |____DynamicCalibrationTests.swift
| |____GazeDetectionTests.swift
| |____WordSuggestionTests.swift
| |____GestureRecognitionTests.swift
| |____KeyboardInteractionTests.swift
| |____BlinkGestureHandlerTests.swift
| |____SwipeToTypeControllerTests.swift
|____info.plist
|____Services
| |____DynamicCalibration.swift
| |____WordSuggestion.swift
| |____.DS_Store
| |____KeyboardInteraction.swift
| |____DependencyInjection.swift
| |____GestureRecognizer.swift
| |____TextEntry.swift
| |____GazeDetection.swift
| |____Settings.swift
| |____EyeTracker.swift
| |____PredictiveTextServerice.swift
| |____TextEntryService.swift
| |____BlinkGestureHandler.swift
|____SceneDelegate.swift

