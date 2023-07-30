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

Please review this updated README and adjust it according to your needs before integrating it into your project.
