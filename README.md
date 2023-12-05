Pheonix

Pheonix is a state-of-the-art iOS custom system keyboard, innovatively designed to be controlled using eye movements. Leveraging advanced eye-tracking technology, it offers a unique typing experience, enhancing accessibility and user interaction.

Architecture

Built with Swift and integrating Apple's ARKit, the Pheonix application comprises a comprehensive architecture:

Models: Handle application states like keyboard layout, text entry, language preferences, and eye movement monitoring.
Services: Core functionalities include eye tracking, gaze detection, dynamic calibration, text entry, and predictive text. Services use sophisticated methods for accuracy and efficiency.
Views: SwiftUI views create a user-friendly interface, focusing on accessibility and intuitive design.
Controllers: Manage interactions between services and views, ensuring smooth operation and user experience.
Delegates and Wrappers: Facilitate communication and event handling among different components of the application.
Features

Eye Tracking
Utilizes ARKit for tracking user gaze and determining key selection. It supports various eye tracking functionalities essential for keyboard control.

Dynamic Calibration
Features a calibration process to adjust eye tracking to individual users' eye movements, using an advanced fractal-based approach.

Predictive Text
Includes a predictive text system for efficient and context-aware word suggestions.

Known Issues and Development Gaps

Based on our comprehensive analysis, the following areas require attention:

Word Suggestion Logic: The generateWordSuggestions(for:) method in WordSuggestion.swift needs implementation.
Dynamic Calibration Data: The DynamicCalibrationModel.swift should move from simulated data to actual data collection.
Eye Tracker Accuracy: Enhance the EyeTracker.swift to precisely translate 3D eye positions into 2D gaze points.
Blink Detection: Improve the BlinkGestureHandler.swift for handling edge cases in blink detection.
Fractal Generation: Clarify and implement the fractal generation in DynamicCalibration.swift.
Text Entry and Predictive Text: Ensure robustness in TextEntryService.swift and predictive text logic.
Settings Validation: Add input validation and feedback mechanisms in SettingsView.swift.
UI Responsiveness: Ensure UI components are responsive and accessible, especially in dynamic scenarios like calibration.
Testing and Contribution

We welcome community involvement in improving Pheonix. For guidelines on testing, reporting issues, and contributing, see our Contribution Guidelines.

Roadmap for Future Development

We plan to enhance eye-tracking algorithms, expand language support, and improve predictive text features. Detailed roadmap information is available here.

Technical and Support Information

For technical details, setup instructions, and support, visit our Support Page or contact support@pheonixapp.com.

This README now accurately reflects our findings and the current state of the Pheonix application. It should be updated regularly as the project evolves, especially in areas related to known issues and upcoming features. Replace placeholders (like URLs or email addresses) with actual information.