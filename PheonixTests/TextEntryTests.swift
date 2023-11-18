import XCTest

class TextEntryTests: XCTestCase {
    var textEntry: TextEntry!
    
    override func setUp() {
        super.setUp()
        textEntry = TextEntry()
        textEntry.appendText("Hello")  // Initialize textEntry with some initial text
    }
    
    override func tearDown() {
        textEntry = nil
        super.tearDown()
    }
    
    func testTextEntry_TextAppended_CorrectText() {
        // Given
        let appendedText = " World"
        
        // When
        textEntry.appendText(appendedText)
        
        // Then
        XCTAssertEqual(textEntry.currentText, "Hello World", "The appended text should be correctly added to the current text.")
    }
    
    // Additional test cases...
}
