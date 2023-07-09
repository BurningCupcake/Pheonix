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
