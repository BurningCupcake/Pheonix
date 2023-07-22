import XCTest


class TextEntryTests: XCTestCase {
    var textEntry: TextEntry!
    
    override func setUp() {
        super.setUp()
        textEntry = TextEntry()
    }
    
    override func tearDown() {
        textEntry = nil
        super.tearDown()
    }
    
    func testTextEntry_TextAppended_CorrectText() {
        // Given
        let initialText = "Hello"
        let appendedText = " World"
        
        // When
        textEntry.appendText(appendedText)
        
        // Then
        XCTAssertEqual(textEntry.currentText, initialText + appendedText, "The appended text should be correctly added to the current text.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the TextEntry class
}
