//The KeyboardLayout struct represents the layout configuration of a keyboard. It includes the following properties:

//layout: A two-dimensional array of strings representing the characters on the keys of the keyboard.
//keySize: A CGSize value specifying the size of each key on the keyboard.
//keyPadding: A CGFloat value representing the padding between keys on the keyboard.
//The KeyboardLayout struct also includes a static method defaultLayout() that returns an instance of KeyboardLayout with the default keyboard layout configuration. The default layout is defined as a two-dimensional array of strings, where each string represents a character on a key. The keySize and keyPadding values are set to default values of 40 and 5 respectively.

//Overall, the KeyboardLayout struct provides a flexible way to define and configure the layout of a keyboard, allowing customization of the key characters, size, and padding.

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
