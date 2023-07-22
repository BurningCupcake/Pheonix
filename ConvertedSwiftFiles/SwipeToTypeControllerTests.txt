import XCTest


class SwipeToTypeControllerTests: XCTestCase {
    var swipeToTypeController: SwipeToTypeController!
    
    override func setUp() {
        super.setUp()
        swipeToTypeController = SwipeToTypeController()
    }
    
    override func tearDown() {
        swipeToTypeController = nil
        super.tearDown()
    }
    
    func testSwipeToTypeController_GestureRecognized_ActionPerformed() {
        // Given
        let action = SwipeAction.left
        var performedAction: SwipeAction?
        
        // When
        swipeToTypeController.handleSwipeGesture(action) { performed in
            performedAction = performed
        }
        
        // Then
        XCTAssertEqual(performedAction, action, "The performed action should match the expected action.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the SwipeToTypeController class
}
