import Foundation

class AppState {
    static let shared = AppState()
    
    // Keyboard state properties
    var isCapsLockEnabled: Bool = false
    var isShiftEnabled: Bool = false
    var selectedLanguage: Language = .english
    var predictiveTextSuggestions: [String] = []
    
    // User preferences
    var isDarkModeEnabled: Bool = false
    
    private init() {
        // Initialize any necessary state properties here
    }
    
    // Update keyboard state based on user actions
    func toggleCapsLock() {
        isCapsLockEnabled = !isCapsLockEnabled
        // Perform any necessary updates or actions when caps lock is toggled
    }
    
    func toggleShift() {
        isShiftEnabled = !isShiftEnabled
        // Perform any necessary updates or actions when shift is toggled
    }
    
    func changeLanguage(to language: Language) {
        selectedLanguage = language
        // Perform any necessary updates or actions when language is changed
    }
    
    // Update predictive text suggestions
    func updatePredictiveTextSuggestions(_ suggestions: [String]) {
        predictiveTextSuggestions = suggestions
        // Perform any necessary updates or actions when predictive text suggestions are updated
    }
    
    // User preference methods
    func toggleDarkMode() {
        isDarkModeEnabled = !isDarkModeEnabled
        // Perform any necessary updates or actions when dark mode is toggled
    }
}
