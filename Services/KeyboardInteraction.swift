// Required library for the code
import Foundation

// Class for handling keyboard interactions
class KeyboardInteraction {
    // The keyboard layout
    private let layout: KeyboardLayout
    // The delegate to notify when a keyboard key is selected
    weak var delegate: KeyboardInteractionDelegate?
    // Instance of text entry service
    private let textEntryService: TextEntryService
    
    // Initializer for the KeyboardInteraction class
    init(layout: KeyboardLayout, textEntryService: TextEntryService) {
        self.layout = layout
        self.textEntryService = textEntryService
    }
    
    // Processes the point of gaze to select a keyboard key
    func processGazePoint(_ point: CGPoint) {
        let keyIndex = calculateKeyIndex(at: point)
        if let key = getKey(at: keyIndex) {
            delegate?.didSelectKey(key)
        }
    }
    
    // Calculate the index of the key at the given point
    private func calculateKeyIndex(at point: CGPoint) -> Int {
        let keySize = layout.keySize
        let keyPadding = layout.keyPadding
        
        let row = Int(point.y / (keySize.height + keyPadding))
        let column = Int(point.x / (keySize.width + keyPadding))
        
        return row * layout.layout[row].count + column
    }
    
    // Get the key at the specified index
    private func getKey(at index: Int) -> String? {
        let flattenedLayout = layout.layout.flatMap { $0 }
        
        guard index >= 0, index < flattenedLayout.count else {
            return nil
        }
        
        return flattenedLayout[index]
    }
}
