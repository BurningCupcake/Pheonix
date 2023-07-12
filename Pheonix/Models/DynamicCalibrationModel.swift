import Combine
import SwiftUI

class DynamicCalibrationModel: ObservableObject {
    @Published var calibrationPoints: [CGPoint] = []
}
