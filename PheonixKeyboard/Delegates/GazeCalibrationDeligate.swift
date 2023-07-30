import Foundation

// Protocol for gaze calibration process.
// The protocol works as a contract or blueprint for classes or structs that want to participate in gaze calibration process
protocol GazeCalibrationDelegate: AnyObject {
    
    // Function to add calibration points during the calibration phase
    // - Parameter point: the calibraion point represented by CGPoint object
    func addCalibrationPoint(_ point: CGPoint)
    
    // Function to clear all previously added calibration points. This is usually called before restarting a calibration process.
    func clearCalibrationPoints()
    
    // Function to calculate calibration result after adding all necessary calibration points.
    // It can return nil if the calculation is not possible, for example there are not enough calibration points.
    // - Returns: Either a `CalibrationResult` object or `nil` if it fails to calculate the result
    func calculateCalibrationResult() -> CalibrationResult?
    
    // Function to perform the overall calibration process
    // It works asynchronously and calls the `completion` closure when it's done. The bool parameter of the closure indicates whether the calibration was successful or not
    // - Parameter completion: closure to be called when calibration is finished
    func performCalibration(completion: @escaping (Bool) -> Void)
}
