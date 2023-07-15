//This file defines a SwiftUI view called CalibrationView that displays the progress of a calibration process. Let's break down the implementation:

//The CalibrationView struct is declared, conforming to the View protocol in SwiftUI.
//It contains a single property:
//dynamicCalibrationModel: An @ObservedObject property that holds an instance of the DynamicCalibrationModel class, which manages the dynamic calibration process.
//The body property describes the view's content using a VStack component.
//Inside the VStack, there are three components:
//A Text view displaying the calibration progress as a percentage based on the number of calibration points collected.
//A ProgressView displaying a progress bar that represents the number of calibration points collected.
//A Button labeled "Start Calibration" that triggers the startCalibration() method on the dynamicCalibrationModel when tapped.
//The view updates automatically whenever changes occur to the dynamicCalibrationModel object, thanks to the @ObservedObject property wrapper.
//Overall, this file defines a SwiftUI view that provides a visual representation of the calibration progress and allows the user to initiate the calibration process by tapping a button.

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
