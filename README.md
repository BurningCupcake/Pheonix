# Eye-Tracking Keyboard Readme

## Introduction

The Eye-Tracking Keyboard is an innovative text input system designed for iOS devices. It leverages advanced computer vision and machine learning algorithms to enable users to type using only their gaze. This document consolidates information from the "Keyeboatd prototype" and "Keyeboard White Sheet" to provide a comprehensive understanding of the Eye-Tracking Keyboard.

## Design Principles

The Eye-Tracking Keyboard is built on the following design principles:

1. **Intuitive and Efficient Input**: The Eye-Tracking Keyboard prioritizes natural and efficient text input by utilizing the user's gaze as the primary input mechanism. The user interface is designed to be intuitive, allowing users to quickly adapt to the eye-tracking input method without extensive training or adjustments.

2. **Dynamic Calibration**: To ensure accurate gaze tracking, the Eye-Tracking Keyboard incorporates a dynamic calibration process. The calibration process is interactive, engaging, and visually appealing, guiding users to establish precise calibration points.

3. **Seamless Interaction**: The keyboard seamlessly integrates into the user interface, with keys morphing and transforming in response to the user's gaze. Interactive animations and visual feedback enhance the user experience, providing clear indications of input actions and improving usability.

4. **Word and Sentence Prediction**: The Eye-Tracking Keyboard employs advanced machine learning algorithms to predict words and sentences based on the user's gaze patterns and typing history. The prediction system continuously adapts and learns from user input to improve accuracy, speed, and personalization.

5. **Gestural Input**: The Eye-Tracking Keyboard introduces innovative blink gestures as an additional input modality. Users can perform actions such as selecting keys, inserting spaces, and deleting characters through well-defined and customizable blink gestures.

## Features

The Eye-Tracking Keyboard offers the following features:

1. **Gaze Tracking**: The Eye-Tracking Keyboard utilizes the device's front-facing camera and infrared (IR) sensor to accurately track the user's gaze. Sophisticated computer vision algorithms analyze eye movements and estimate the gaze point on the screen with exceptional precision.

2. **Dynamic Calibration**: The Eye-Tracking Keyboard incorporates a captivating and interactive fractal visualization for dynamic calibration. This visualization guides the user's gaze across the screen, ensuring optimal calibration accuracy and reducing calibration time.

3. **Key Morphing and Interaction**: With the Eye-Tracking Keyboard, keys transform dynamically as the user gazes at them, adapting to the user's visual context and preferences. Interactive animations provide immediate feedback when a key is selected, creating a delightful and engaging typing experience.

4. **Blink Gesture Interaction**: The Eye-Tracking Keyboard revolutionizes text input by introducing blink gestures as a natural and effortless input mechanism. Blink detection algorithms analyze eye blinks, allowing users to perform actions such as key selection, space insertion, and character deletion.

5. **Word and Sentence Prediction**: The Eye-Tracking Keyboard employs cutting-edge machine learning algorithms to predict words and sentences. The prediction system takes into account the user's gaze patterns, typing history, and contextual information, generating highly accurate suggestions in real-time.

6. **User Interface and User Experience (UI/UX)**: The Eye-Tracking Keyboard's user interface is meticulously designed to prioritize usability, clarity, and aesthetics. The interface features a visually appealing and responsive keyboard layout that adapts seamlessly to user interactions, creating a delightful typing experience. Clear visual feedback, animations, and intuitive interactions guide users throughout the typing process, making it a user-friendly and enjoyable experience.

## Implementation

The Eye-Tracking Keyboard is implemented using the following architecture and technologies:

1. **Architecture**: The Eye-Tracking Keyboard follows the Model-View-ViewModel (MVVM) architectural pattern, providing a clear separation of concerns and promoting maintainability and extensibility. The codebase is organized into modular components, ensuring reusability and facilitating testing and debugging processes.

2. **Technology Stack**: The Eye-Tracking Keyboard is developed using the Swift programming language for iOS devices. The implementation utilizes the power of ARKit for gaze tracking and facial landmark detection. Machine learning algorithms are integrated using Core ML, enabling accurate word and sentence prediction based on user input and context.

3. **Accessibility and Localization**: The Eye-Tracking Keyboard prioritizes accessibility, adhering to accessibility standards and providing support for alternative input methods. Localization and internationalization features allow the keyboard to adapt seamlessly to different languages and regions, ensuring a global user base.

## Conclusion

The Eye-Tracking Keyboard represents a paradigm shift in text input, leveraging the power of gaze tracking and machine learning to provide an intuitive, efficient, and accessible typing experience. With dynamic calibration, interactive key morphing, blink gestures, and intelligent word prediction, the Eye-Tracking Keyboard enhances productivity and revolutionizes the way users interact with digital devices. By adhering to the design principles outlined in this readme and implementing the features described, the Eye-Tracking Keyboard aims to empower users and unlock their full potential in the realm of text input.

## Future Work and Improvements

While the current implementation of the Eye-Tracking Keyboard provides a robust and innovative text input system, there are several areas for potential improvement and future work:


1. **Code Refactoring**: Some parts of the codebase could benefit from refactoring to improve readability, maintainability, and performance. This includes adhering to best practices for Swift programming, improving function and variable naming, and optimizing algorithms and data structures.

2. **Testing**: The project could benefit from more comprehensive testing, including unit tests, integration tests, and end-to-end tests. This would help ensure the reliability and robustness of the keyboard.

3. **Documentation**: While the project has a good level of documentation, there is room for improvement. More detailed comments in the code, as well as more comprehensive technical documentation, would make the project easier to understand and maintain.

4. **User Interface Improvements**: While the user interface of the keyboard is already intuitive and visually appealing, there is always room for improvement. User feedback could be used to make further refinements to the UI.

5. Performance Optimization**: The performance of the gaze tracking and word prediction algorithms could potentially be improved. This could involve optimizing the algorithms themselves, as well as improving the efficiency of the code.

Full Program File Tree:

.
├── .DS_Store
├── PheonixUITests
│   └── KeyboardUITests.swift
├── Pheonix.xcodeproj
│   ├── project.pbxproj
│   ├── xcuserdata
│   │   └── justinfortier.xcuserdatad
│   │       ├── xcdebugger
│   │       │   └── Breakpoints_v2.xcbkptlist
│   │       └── xcschemes
│   │           └── xcschememanagement.plist
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcuserdata
│   │   │   └── justinfortier.xcuserdatad
│   │   │       ├── IDEFindNavigatorScopes.plist
│   │   │       ├── WorkspaceSettings.xcsettings
│   │   │       └── UserInterfaceState.xcuserstate
│   │   └── xcshareddata
│   │       ├── IDEWorkspaceChecks.plist
│   │       ├── WorkspaceSettings.xcsettings
│   │       └── swiftpm
│   │           └── configuration
│   └── xcshareddata
│       └── xcschemes
│           ├── PheonixKeyboard.xcscheme
│           └── Pheonix.xcscheme
├── Models
│   ├── AppState.swift
│   ├── KeyboardKey.swift
│   ├── Language.swift
│   ├── EyeState.swift
│   ├── .DS_Store
│   ├── PredictiveTextViewModel.swift
│   ├── TextEntryViewModel.swift
│   ├── Key.swift
│   ├── KeyboardViewModel.swift
│   ├── TextEntryError.swift
│   ├── DynamicCalibrationModel.swift
│   ├── CalibrationResult.swift
│   ├── EyeMovementMonitor.swift
│   ├── KeyboardLayoutStyle.swift
│   └── KeyboardLayout.swift
├── README.md
├── convert_to_txt.sh
├── TestPlan.xctestplan
├── Pheonix
│   ├── .DS_Store
│   ├── Resources
│   │   ├── Keyboard.xib
│   │   └── IMG_6989.jpg
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Supporting Files
│   │   └── Assets.xcassets
│   │       ├── AppIcon.appiconset
│   │       │   ├── IMG_6989.jpg
│   │       │   └── Contents.json
│   │       ├── AccentColor.colorset
│   │       │   └── Contents.json
│   │       └── Contents.json
│   └── info.plist
├── AppDelegate.swift (missing)
├── PheonixKeyboard
│   ├── .DS_Store
│   ├── Delegates
│   │   ├── KeyboardViewDelegateWrapper.swift
│   │   ├── EyeTrackerDelegate.swift
│   │   ├── CalibrationDelegate.swift
│   │   ├── WordSuggestionDelegate.swift
│   │   ├── .DS_Store
│   │   ├── BlinkGestureHandlerDelegate.swift
│   │   ├── GazeCalibrationDeligate.swift
│   │   ├── SpellingIndicatorDelegateWrapper.swift
│   │   ├── KeyboardViewDelegate.swift
│   │   ├── KeyboardInteractionDelegate.swift
│   │   ├── GazeDetectionDelegate.swift
│   │   ├── GestureRecognitionDelegate.swift
│   │   ├── WordSugestionDelegateWrapper.swift
│   │   └── SwipeToTypeControllerDelegate.swift
│   ├── Controllers
│   │   ├── .DS_Store
│   │   ├── EyeTrackingController.swift
│   │   ├── KeyboardViewController.swift
│   │   ├── SwipeToTypeController.swift
│   │   └── EyeGazeViewController.swift
│   ├── Views
│   │   ├── CalibrationView.swift
│   │   ├── KeyboardKey.swift
│   │   ├── CalibrationProgressView.swift
│   │   ├── PredictiveTextView.swift
│   │   ├── SettingsView.swift
│   │   ├── .DS_Store
│   │   ├── DynamicCalibrationView.swift
│   │   ├── TextEntryView.swift
│   │   ├── KeyboardView.swift
│   │   ├── Keyboard.swift
│   │   ├── LanguagePickerView.swift
│   │   ├── SwipeToTypeView.swift
│   │   └── ContentView.swift
│   └── Info.plist
├── Iphone.mobileprovision
├── main.swift
├── PheonixTests
│   ├── EyeTrackerTests.swift
│   ├── TextEntryTests.swift
│   ├── DynamicCalibrationTests.swift
│   ├── GazeDetectionTests.swift
│   ├── WordSuggestionTests.swift
│   ├── GestureRecognitionTests.swift
│   ├── KeyboardInteractionTests.swift
│   ├── BlinkGestureHandlerTests.swift
│   └── SwipeToTypeControllerTests.swift
├── info.plist
├── Services
│   ├── DynamicCalibration.swift
│   ├── WordSuggestion.swift
│   ├── .DS_Store
│   ├── KeyboardInteraction.swift
│   ├── DependencyInjection.swift
│   ├── GestureRecognizer.swift
│   ├── TextEntry.swift
│   ├── GazeDetection.swift
│   ├── Settings.swift
│   ├── EyeTracker.swift
│   ├── PredictiveTextServerice.swift
│   ├── TextEntryService.swift
│   └── BlinkGestureHandler.swift
└── SceneDelegate.swift
