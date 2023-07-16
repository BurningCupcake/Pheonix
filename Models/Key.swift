//This is a SwiftUI View called Key that represents a keyboard key. It takes a character parameter, which is the text to be displayed on the key.

//The body of the Key view consists of a Text view displaying the character text. It is styled with a system font of size 24. The Text view is then enclosed in a frame with a width and height of 40, creating a square key shape.

//The key has a white background with black text color, giving it a classic keyboard key appearance. It has rounded corners with a corner radius of 5. Additionally, there is a subtle shadow effect applied to the key using the shadow modifier.

//This Key view can be used to represent individual keys in a keyboard layout or any other interface that requires displaying keys with specific styles.

import SwiftUI

struct Key: View {
    var character: String
    
    var body: some View {
        Text(character)
            .font(.system(size: 24))
            .frame(width: 40, height: 40)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: 1)
    }
}
