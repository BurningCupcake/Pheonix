import XCTest


class WordSuggestionTests: XCTestCase {
    var wordSuggestion: WordSuggestion!
    
    override func setUp() {
        super.setUp()
        wordSuggestion = WordSuggestion()
    }
    
    override func tearDown() {
        wordSuggestion = nil
        super.tearDown()
    }
    
    func testWordSuggestion_SuggestWords_CorrectWords() {
        // Given
        let text = "Hello"
        let expectedWords = ["Hello", "Hell", "Help"]
        
        // When
        wordSuggestion.processTextEntry(text)
        
        // Then
        XCTAssertEqual(wordSuggestion.suggestedWords, expectedWords, "The suggested words should match the expected words based on the input text.")
    }
    
    // Add more test cases to cover other functionalities and scenarios of the WordSuggestion class
}
