import SwiftUI

// A SwiftUI View that represents a key with a character.
struct Key: View {
    // The character that the key will display.
    var character: String
    
    // The body of the key view.
    var body: some View {
        // The character is displayed as text.
        Text(character)
            // The font size of the character is 24 points.
            .font(.system(size: 24))
            // The frame of the key is a 40x40 square.
            .frame(width: 40, height: 40)
            // The background color of the key is white.
            .background(Color.white)
            // The color of the character text is black.
            .foregroundColor(Color.black)
            // The corners of the key are slightly rounded with a radius of 5.
            .cornerRadius(5)
            // The key has a slight shadow, of black color with 20% opacity,
            // with a radius of 1, offset by 1 point to the right and 1 point down.
            .shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: 1)
    }
}
