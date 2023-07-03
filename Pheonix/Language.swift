
import Foundation

enum Language: String, CaseIterable {
    case english = "English"
    case french = "French"
    case spanish = "Spanish"
    // Add more languages as necessary
    
    var localizedDisplayName: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
