// The Foundation framework is imported for its tools & functionalities such as localization
import Foundation

// Defines an enumeration named `Language`. 
// It conforms to the `String` and `CaseIterable` protocols. 
// `CaseIterable` protocol automatically provides a collection of all its values.
enum Language: String, CaseIterable {

    // Enum cases are different language options
    case english = "English"
    case french = "French"
    case spanish = "Spanish"
    case chinese = "Chinese"
    case german = "German"
    case italian = "Italian"
    case japanese = "Japanese"
    case portuguese = "Portuguese"
    case russian = "Russian"
    case hindi = "Hindi"
    case arabic = "Arabic"
    case korean = "Korean"

    // Computed property `localizedDisplayName` generates localized name of language
    // Uses `NSLocalizedString` for i18n and l10n support
    var localizedDisplayName: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
