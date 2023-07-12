import SwiftUI

struct CalibrationView: View {
    @ObservedObject var dynamicCalibrationModel: DynamicCalibrationModel
    
    var body: some View {
        VStack {
            Text("Calibration Progress: \(dynamicCalibrationModel.calibrationProgress * 100)%")
            ProgressView(value: dynamicCalibrationModel.calibrationProgress)
            Button("Start Calibration") {
                dynamicCalibrationModel.startCalibration()
            }
        }
    }
}
