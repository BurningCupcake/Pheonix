import Foundation

class KeyboardInteraction {
    private let layout: KeyboardLayout
    weak var delegate: KeyboardInteractionDelegate?
    private let textEntryService: TextEntryService // Add this property to hold the instance of TextEntryService
    
    init(layout: KeyboardLayout, textEntryService: TextEntryService) {
        self.layout = layout
        self.textEntryService = textEntryService
    }
    
    func processGazePoint(_ point: CGPoint) {
        let keyIndex = calculateKeyIndex(at: point)
        if let key = getKey(at: keyIndex) {
            delegate?.didSelectKey(key, textEntryService: textEntryService) // Pass the textEntryService argument
        }
    }
    private func calculateKeyIndex(at point: CGPoint) -> Int {
        let keySize = layout.keySize
        let keyPadding = layout.keyPadding
        
        let row = Int(point.y / (keySize.height + keyPadding))
        let column = Int(point.x / (keySize.width + keyPadding))
        
        return row * layout.layout[row].count + column
    }
    
    private func getKey(at index: Int) -> String? {
        let flattenedLayout = layout.layout.flatMap { $0 }
        
        guard index >= 0, index < flattenedLayout.count else {
            return nil
        }
        
        return flattenedLayout[index]
    }
}

