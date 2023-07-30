import SwiftUI

// A SwiftUI view displaying calibration progress
struct CalibrationProgressView: View {
    // A binding (two-way connection) to the progress, expressed as a double ranging from 0 to 1
    @Binding var progress: Double
    
    // The body of the SwiftUI view
    var body: some View {
        // A vertical stack for aligning content
        VStack {
            // Display title text for the calibration progress
            Text("Calibration Progress")
                .font(.title) // Set the font for the text
                .padding() // Add padding around the text

            // A ProgressView showing a circular progress bar based on the `progress`
            ProgressView(value: progress, total: 1)
                .progressViewStyle(CircularProgressViewStyle()) // Set the style to a circular view
                .padding() // Add padding around the ProgressView

            // Text showing percentage of calibration progress
            Text("\(Int(progress * 100))% Complete")
                .font(.headline) // Set the font for the text
        }
    }
}
