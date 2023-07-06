import XCTest
@testable import Pheonix

class BlinkGestureHandlerTests: XCTestCase {
    var blinkGestureHandler: BlinkGestureHandler!
    var delegateMock: BlinkGestureHandlerDelegateMock!
    
    override func setUp() {
        super.setUp()
        blinkGestureHandler = BlinkGestureHandler()
        delegateMock = BlinkGestureHandlerDelegateMock()
        blinkGestureHandler.delegate = delegateMock
    }
    
    override func tearDown() {
        blinkGestureHandler = nil
        delegateMock = nil
        super.tearDown()
    }
    
    func testBlinkGestureHandler_DidDetectBlink_DelegateCalled() {
        // Given
        let expectedDelegateCallCount = 1
        
        // When
        blinkGestureHandler.processEyeState(.open)
        blinkGestureHandler.processEyeState(.closed)
        
        // Then
        XCTAssertEqual(delegateMock.didDetectBlinkCallCount, expectedDelegateCallCount, "Delegate method didDetectBlink should have been called once.")
    }
}

// Mock class for BlinkGestureHandlerDelegate
class BlinkGestureHandlerDelegateMock: BlinkGestureHandlerDelegate {
    var didDetectBlinkCallCount = 0
    
    func didDetectBlink() {
        didDetectBlinkCallCount += 1
    }
}
