import Foundation
import CoreGraphics

// Struct representing a keyboard layout
public struct KeyboardLayout {

    // 2D array representation of the keyboard layout.
    // Each inner array is a row on the keyboard; from top to bottom.
    // Each string in the inner array represents a key on that row from left to right.
    var layout: [[String]]
    
    // The dimensions of each key, represented as a CGSize.
    var keySize: CGSize 

    // The padding distance between keys.
    var keyPadding: CGFloat 
    
    // Static function returning a default keyboard layout.
    static func defaultLayout() -> KeyboardLayout {
        
        // Default keyboard layout.
        let defaultLayout: [[String]] = [
            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
            ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
            ["Z", "X", "C", "V", "B", "N", "M"]
        ]
        
        // Default size of keys.
        let keySize = CGSize(width: 40, height: 40)

        // Default padding between keys.
        let keyPadding: CGFloat = 5
        
        // Return a new KeyboardLayout instance with the defined default values.
        return KeyboardLayout(layout: defaultLayout, keySize: keySize, keyPadding: keyPadding)
    }
}
