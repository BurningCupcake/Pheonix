class GestureRecognizer {
    weak var delegate: GestureRecognitionDelegate?
    
    func recognizeGesture() {
        // Recognize the gesture...
        
        // If a blink gesture is recognized, notify the delegate
        delegate?.gestureRecognizer(self, didRecognizeGesture: .blink)
    }
}
