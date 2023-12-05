import SwiftUI

// `CalibrationView` struct conforms to the `View` protocol to compose the dynamic user interface of the app.
struct DynamicCalibrationView: View {
    // `@ObservedObject` property wrapper is used to subscribe to an observable object (`dynamicCalibrationModel`), 
    // for the view updates when changes occur in that object.
    @ObservedObject var dynamicCalibrationModel: DynamicCalibrationModel
    
    // The `body` property returns some View that SwiftUI displays. 
    var body: some View {
        // VStack combines views vertically.
        VStack {
            // The `Text` view displays read-only text. It's showing the progress of calibration in percentage format.
            Text("Calibration Progress: \(Int(dynamicCalibrationModel.calibrationPoints.count * 100))%")
            // `ProgressView` shows the progress of a task over time.
            ProgressView(value: Double(dynamicCalibrationModel.calibrationPoints.count))
            // `Button` view represents a button that users can tap or click.
            Button("Start Calibration") {
                // Invoking `startCalibration()` method of the `dynamicCalibrationModel` when the button is tapped.
                dynamicCalibrationModel.startCalibration()
            }
        }.onAppear {
            // When this view appears on screen, `startCalibration()` method of the `dynamicCalibrationModel` is invoked
            dynamicCalibrationModel.startCalibration()
        }
    }
}
