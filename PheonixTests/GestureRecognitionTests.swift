import XCTest
@testable import Pheonix

class GestureRecognitionTests: XCTestCase {
    var gestureRecognition: GestureRecognition!
    
    override func setUp() {
        super.setUp()
        gestureRecognition = GestureRecognition()
    }
    
    override func tearDown() {
        gestureRecognition = nil
        super.tearDown()
    }
    
    func testGestureRecognition_DetectBlinkGesture_BlinkGestureDetected() {
        // Given
        let eyeState: EyeState = .closed
        var blinkGestureDetected = false
        
        // When
        gestureRecognition.processEyeState(eyeState) { gestureDetected in
            blinkGestureDetected = gestureDetected
        }
        
        // Then
        XCTAssertTrue(blinkGestureDetected, "Blink gesture should be detected.")
    }
    
    func testGestureRecognition_DetectNonBlinkGesture_NoBlinkGestureDetected() {
        // Given
        let eyeState: EyeState = .open
        var blinkGestureDetected = false
        
        // When
        gestureRecognition.processEyeState(eyeState) { gestureDetected in
            blinkGestureDetected = gestureDetected
        }
        
        // Then
        XCTAssertFalse(blinkGestureDetected, "No blink gesture should be detected.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the GestureRecognition class
}
