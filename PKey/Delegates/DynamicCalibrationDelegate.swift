import simd

protocol DynamicCalibrationDelegate: AnyObject {
    // This method is called when the DynamicCalibration object has updated the eye offset
    func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3)
    
    // Methods to manage the calibration process
    func didStartCalibration()
    func didCompleteCalibration(withResult result: CalibrationResult)
    func didFailCalibration(withError error: Error)
}

