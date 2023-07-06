import XCTest
@testable import Pheonix

class DynamicCalibrationTests: XCTestCase {
    var dynamicCalibration: DynamicCalibration!
    
    override func setUp() {
        super.setUp()
        dynamicCalibration = DynamicCalibration()
    }
    
    override func tearDown() {
        dynamicCalibration = nil
        super.tearDown()
    }
    
    func testDynamicCalibration_StartCalibration_CalibrationInProgress() {
        // Given
        let expectedState = CalibrationState.inProgress
        
        // When
        dynamicCalibration.startCalibration()
        
        // Then
        XCTAssertEqual(dynamicCalibration.calibrationState, expectedState, "Calibration state should be in progress after starting calibration.")
    }
    
    func testDynamicCalibration_FinishCalibration_CalibrationFinished() {
        // Given
        let expectedState = CalibrationState.finished
        
        // When
        dynamicCalibration.finishCalibration()
        
        // Then
        XCTAssertEqual(dynamicCalibration.calibrationState, expectedState, "Calibration state should be finished after finishing calibration.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the DynamicCalibration class
}

