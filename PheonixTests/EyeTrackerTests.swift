import XCTest
@testable import Pheonix

class EyeTrackerTests: XCTestCase {
    var eyeTracker: EyeTracker!
    
    override func setUp() {
        super.setUp()
        eyeTracker = EyeTracker()
    }
    
    override func tearDown() {
        eyeTracker = nil
        super.tearDown()
    }
    
    func testEyeTracker_StartTracking_EyeTrackingStarted() {
        // Given
        let expectedState = EyeTrackingState.started
        
        // When
        eyeTracker.startTracking()
        
        // Then
        XCTAssertEqual(eyeTracker.eyeTrackingState, expectedState, "Eye tracking state should be started after calling startTracking.")
    }
    
    func testEyeTracker_StopTracking_EyeTrackingStopped() {
        // Given
        let expectedState = EyeTrackingState.stopped
        
        // When
        eyeTracker.stopTracking()
        
        // Then
        XCTAssertEqual(eyeTracker.eyeTrackingState, expectedState, "Eye tracking state should be stopped after calling stopTracking.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the EyeTracker class
}
