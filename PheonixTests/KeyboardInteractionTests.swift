import XCTest
@testable import Pheonix

class KeyboardInteractionTests: XCTestCase {
    var keyboardInteraction: KeyboardInteraction!
    
    override func setUp() {
        super.setUp()
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout())
    }
    
    override func tearDown() {
        keyboardInteraction = nil
        super.tearDown()
    }
    
    func testKeyboardInteraction_SelectKey_KeySelected() {
        // Given
        let key = "A"
        var selectedKey: String?
        
        // When
        keyboardInteraction.selectKey(key) { selected in
            selectedKey = selected
        }
        
        // Then
        XCTAssertEqual(selectedKey, key, "The selected key should match the expected key.")
    }
    
    func testKeyboardInteraction_SwipeToType_LeftSwipeAction_PerformsAction() {
        // Given
        let action = SwipeAction.left
        var performedAction: SwipeAction?
        
        // When
        keyboardInteraction.swipeToType(action) { performed in
            performedAction = performed
        }
        
        // Then
        XCTAssertEqual(performedAction, action, "The performed action should match the expected action.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the KeyboardInteraction class
}

