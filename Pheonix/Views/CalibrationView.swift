import SwiftUI

struct CalibrationView: View {
    @ObservedObject var dynamicCalibrationModel: DynamicCalibrationModel
    
    var body: some View {
        VStack {
            Text("Calibration Progress: \(Int(dynamicCalibrationModel.calibrationPoints.count * 100))%")
            ProgressView(value: Double(dynamicCalibrationModel.calibrationPoints.count))
            Button("Start Calibration") {
                dynamicCalibrationModel.startCalibration()
            }
        }
    }
}

