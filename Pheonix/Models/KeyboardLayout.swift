import Foundation

struct KeyboardLayout {
    var layout: [[String]]
    var keySize: CGSize
    var keyPadding: CGFloat
    
    static func defaultLayout() -> KeyboardLayout {
        // Define the default keyboard layout
        
        return KeyboardLayout(layout: [], keySize: CGSize.zero, keyPadding: 0)
    }
}
