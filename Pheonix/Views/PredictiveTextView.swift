import SwiftUI

struct PredictiveTextView: View {
    var suggestions: [String]
    
    var body: some View {
        // Predictive text view UI code goes here
        HStack {
            ForEach(suggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .font(.subheadline)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

