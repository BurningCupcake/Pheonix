import Foundation

protocol GazeCalibrationDelegate: AnyObject {
    func addCalibrationPoint(_ point: CGPoint)
    func clearCalibrationPoints()
    func calculateCalibrationResult() -> CalibrationResult?
    func performCalibration(completion: @escaping (Bool) -> Void)
}
