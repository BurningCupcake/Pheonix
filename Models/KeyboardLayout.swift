
import Foundation
import CoreGraphics

public struct KeyboardLayout {
    var layout: [[String]]
    var keySize: CGSize
    var keyPadding: CGFloat
    
    static func defaultLayout() -> KeyboardLayout {
        // Define the default keyboard layout
        
        let defaultLayout: [[String]] = [
            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
            ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
            ["Z", "X", "C", "V", "B", "N", "M"]
        ]
        
        let keySize = CGSize(width: 40, height: 40)
        let keyPadding: CGFloat = 5
        
        return KeyboardLayout(layout: defaultLayout, keySize: keySize, keyPadding: keyPadding)
    }
}
