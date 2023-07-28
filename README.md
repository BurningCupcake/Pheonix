# Eye-Tracking Keyboard Readme

This readme provides a technical overview of the design principles, features, and implementation details of the Eye-Tracking Keyboard prototype.

## Introduction

The Eye-Tracking Keyboard is an innovative text input system designed for iOS devices. It leverages advanced computer vision and machine learning algorithms to enable users to type using only their gaze. This document consolidates information from the "Keyeboatd prototype" and "Keyeboard White Sheet" to provide a comprehensive understanding of the Eye-Tracking Keyboard.

## Design Principles

The Eye-Tracking Keyboard is built on the following design principles:

1. Intuitive and Efficient Input: The Eye-Tracking Keyboard prioritizes natural and efficient text input by utilizing the user's gaze as the primary input mechanism. The user interface is designed to be intuitive, allowing users to quickly adapt to the eye-tracking input method without extensive training or adjustments.

2. Dynamic Calibration: To ensure accurate gaze tracking, the Eye-Tracking Keyboard incorporates a dynamic calibration process. The calibration process is interactive, engaging, and visually appealing, guiding users to establish precise calibration points.

3. Seamless Interaction: The keyboard seamlessly integrates into the user interface, with keys morphing and transforming in response to the user's gaze. Interactive animations and visual feedback enhance the user experience, providing clear indications of input actions and improving usability.

4. Word and Sentence Prediction: The Eye-Tracking Keyboard employs advanced machine learning algorithms to predict words and sentences based on the user's gaze patterns and typing history. The prediction system continuously adapts and learns from user input to improve accuracy, speed, and personalization.

5. Gestural Input: The Eye-Tracking Keyboard introduces innovative blink gestures as an additional input modality. Users can perform actions such as selecting keys, inserting spaces, and deleting characters through well-defined and customizable blink gestures.

## Features

The Eye-Tracking Keyboard offers the following features:

1. Gaze Tracking: The Eye-Tracking Keyboard utilizes the device's front-facing camera and infrared (IR) sensor to accurately track the user's gaze. Sophisticated computer vision algorithms analyze eye movements and estimate the gaze point on the screen with exceptional precision.

2. Dynamic Calibration: The Eye-Tracking Keyboard incorporates a captivating and interactive fractal visualization for dynamic calibration. This visualization guides the user's gaze across the screen, ensuring optimal calibration accuracy and reducing calibration time. The fractals are tendrils starting from below the keys. Like they are emerging from the depths, curious about their new environment. They are attracted to the users eyes and start tracking their movements, effecting the direction they are growing. As the grow and move around, they start effecting the keys and incorporating them into the fractal pattern and color shifting. I’m thinking we can utilize the coiled fern pattern from the Mandelbrot set as a great starting point. As the fractal grows organically through the equation, it also grows to take over all of the keys and the entire keyboard pane. During all of this, the keyboard can watch the math from the fractal and determine the point of interest of the users eye utilizing the psychology of point of interest. This would allow an organic calibration process. Once complete and the pane is full, everything regresses pack to normal and the keyboard is ready for use.

3. Key Morphing and Interaction: With the Eye-Tracking Keyboard, keys transform dynamically as the user gazes at them, adapting to the user's visual context and preferences. Interactive animations provide immediate feedback when a key is selected, creating a delightful and engaging typing experience.

4. Blink Gesture Interaction: The Eye-Tracking Keyboard revolutionizes text input by introducing blink gestures as a natural and effortless input mechanism. Blink detection algorithms analyze eye blinks, allowing users to perform actions such as key selection, space insertion, and character deletion.

5. Word and Sentence Prediction: The Eye-Tracking Keyboard employs cutting-edge machine learning algorithms to predict words and sentences. The prediction system takes into account the user's gaze patterns, typing history, and contextual information, generating highly accurate suggestions in real-time.

6. User Interface and User Experience (UI/UX): The Eye-Tracking Keyboard's user interface is meticulously designed to prioritize usability, clarity, and aesthetics. The interface features a visually appealing and responsive keyboard layout that adapts seamlessly to user interactions, creating a delightful typing experience. Clear visual feedback, animations, and intuitive interactions guide users throughout the typing process, making it a user-friendly and enjoyable experience.

## Implementation

The Eye-Tracking Keyboard is implemented using the following architecture and technologies:

1. Architecture: The Eye-Tracking Keyboard follows the Model-View-ViewModel (MVVM) architectural pattern, providing a clear separation of concerns and promoting maintainability and extensibility. The codebase is organized into modular components, ensuring reusability and facilitating testing and debugging processes.

   The key classes and components in the implementation are as follows:
   - BlinkGestureHandler: Responsible for detecting blinks using eye state information.
   - DependencyInjection: Implements the singleton pattern and provides access to various dependencies used in the application.
   - EyeTracker: Uses ARKit for gaze tracking and facial landmark detection.
   - GazeDetection: Utilizes the eye tracker to detect the user's gaze direction.
   - GestureRecognition: Recognizes gestures based on changes in the eye state.
   - KeyboardInteraction: Handles user interaction with the keyboard layout.
   - PredictiveTextService: Provides predictive text suggestions based on the user's text input.
   - TextEntryService: Manages the current text entry state and performs text manipulation operations.
   - Settings: Stores various settings related to the keyboard, eye tracking, calibration, swipe-to-type, blink gesture, etc.
   - CalibrationDelegate: Defines methods for handling the calibration process.
   - CalibrationDelegateImplementation: Implements the CalibrationDelegate protocol and performs dynamic calibration using calibration points.
   - EyeTrackerDelegate: Defines methods for receiving gaze point updates from the eye tracker.
   - GazeDetectionDelegate: Defines a method for receiving gaze detection updates.
   - GestureType: Represents the types of gestures that can be recognized.
   - KeyboardViewDelegate: Defines methods for handling key selection and updating word suggestions.
   - SceneDelegate: Sets up the main window for the application using SwiftUI's ContentView.
   - WordSuggestionDelegate: Defines a method for receiving word suggestions.

2. Technology Stack: The Eye-Tracking Keyboard is developed using the Swift programming language for iOS devices. The implementation utilizes the power of ARKit for gaze tracking and facial landmark detection. Machine learning algorithms are integrated using Core ML, enabling accurate word and sentence prediction based on user input and context.

3. Accessibility and Localization: The Eye-Tracking Keyboard prioritizes accessibility, adhering to accessibility standards and providing support for alternative input methods. Localization and internationalization features allow the keyboard to adapt seamlessly to different languages and regions, ensuring a global user base.

## Conclusion

The Eye-Tracking Keyboard represents a paradigm shift in text input, leveraging the power of gaze tracking and machine learning to provide an intuitive, efficient, and accessible typing experience. With dynamic calibration, interactive key morphing, blink gestures, and intelligent word prediction, the Eye-Tracking Keyboard enhances productivity and revolutionizes the way users interact with digital devices. By adhering to the design principles outlined in this readme and implementing the features described, the Eye-Tracking Keyboard aims to empower users and unlock their full potential in the realm of text input.
