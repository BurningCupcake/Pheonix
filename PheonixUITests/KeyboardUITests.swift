import XCTest
@testable import Pheonix

class KeyboardUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testTyping() {
        // Simulate tapping on keys to type
        app.keys["A"].tap()
        app.keys["B"].tap()
        app.keys["C"].tap()
        
        // Assert that the text input has the expected value
        XCTAssertEqual(app.textFields["textInput"].value as? String, "ABC")
    }
    
    func testWordSuggestion() {
        // Simulate tapping on keys to type
        app.keys["H"].tap()
        app.keys["E"].tap()
        app.keys["L"].tap()
        
        // Assert that the word suggestion appears
        XCTAssertTrue(app.staticTexts["wordSuggestion"].exists)
        
        // Tap on the word suggestion
        app.staticTexts["Hello"].tap()
        
        // Assert that the text input has the selected suggestion
        XCTAssertEqual(app.textFields["textInput"].value as? String, "Hello")
    }
    
    // Add more test cases to cover different keyboard functionality
    
}
