import Foundation

enum KeyboardLayoutStyle: String, CaseIterable {
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
    
    var localizedDisplayName: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
