// Importing Foundation framework to utilize built-in swift libraries
import Foundation

// Define an enumeration that conforms to the Error protocol
// This enumeration will represent potential errors that may occur when dealing with text entries
enum TextEntryError: Error {
    // This case represents an error that might occur when an invalid gaze point is detected
    case invalidGazePoint
    // This case represents an error that might occur when the text entered is too long
    case textTooLong
}
