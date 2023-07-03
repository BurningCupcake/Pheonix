import XCTest
@testable import Pheonix

class GazeDetectionTests: XCTestCase {
    var gazeDetection: GazeDetection!
    
    override func setUp() {
        super.setUp()
        gazeDetection = GazeDetection()
    }
    
    override func tearDown() {
        gazeDetection = nil
        super.tearDown()
    }
    
    func testGazeDetection_StartGazeDetection_GazeDetectionStarted() {
        // Given
        let expectedState = GazeDetectionState.started
        
        // When
        gazeDetection.startGazeDetection()
        
        // Then
        XCTAssertEqual(gazeDetection.gazeDetectionState, expectedState, "Gaze detection state should be started after calling startGazeDetection.")
    }
    
    func testGazeDetection_StopGazeDetection_GazeDetectionStopped() {
        // Given
        let expectedState = GazeDetectionState.stopped
        
        // When
        gazeDetection.stopGazeDetection()
        
        // Then
        XCTAssertEqual(gazeDetection.gazeDetectionState, expectedState, "Gaze detection state should be stopped after calling stopGazeDetection.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the GazeDetection class
}
