import SwiftUI

struct CalibrationProgressView: View {
    @Binding var progress: Double
    
    var body: some View {
        VStack {
            Text("Calibration Progress")
                .font(.title)
                .padding()
            
            ProgressView(value: progress, total: 1)
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
            
            Text("\(Int(progress * 100))% Complete")
                .font(.headline)
        }
    }
}
