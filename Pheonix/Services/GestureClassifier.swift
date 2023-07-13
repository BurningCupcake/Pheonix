import foundation

class GestureClassifier {
    private let gestureKeywords: Set<String>
    
    init(gestureKeywords: Set<String>) {
        self.gestureKeywords = gestureKeywords
    }
    
    func isGesture(_ keyword: String) -> Bool {
        return gestureKeywords.contains(keyword.lowercased())
    }
}
