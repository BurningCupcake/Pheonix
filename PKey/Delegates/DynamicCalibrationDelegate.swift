import simd

protocol DynamicCalibrationDelegate: AnyObject {
    // This method is called when the DynamicCalibration object has updated the eye offset
    func dynamicCalibration(_ dynamicCalibration: DynamicCalibration, didUpdateEyeOffset eyeOffset: simd_float3)
}
