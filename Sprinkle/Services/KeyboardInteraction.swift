import Foundation

class KeyboardInteraction {
    private let layout: KeyboardLayout
    
    init(layout: KeyboardLayout) {
        self.layout = layout
    }
    
    func processGazePoint(_ point: CGPoint) {
        // Implement your logic here
        // For example, you could calculate the key at the gaze point and trigger its selection
        
        // Here's a simple example of how you could determine the key based on the gaze point
        let keyIndex = calculateKeyIndex(at: point)
        if let key = getKey(at: keyIndex) {
            delegate?.didSelectKey(key)
        }
    }
    
    private func calculateKeyIndex(at point: CGPoint) -> Int {
        // Implement your logic to calculate the key index based on the gaze point
        // For example, you could map the gaze point to a specific key on the keyboard layout
        // and return its index
        
        // Here's a simple example where we assume the keyboard layout is an array of keys
        let totalKeys = layout.layout.flatMap { $0 }.count
        let keySize = layout.keySize
        let keyPadding = layout.keyPadding
        
        let row = Int(point.y / (keySize.height + keyPadding))
        let column = Int(point.x / (keySize.width + keyPadding))
        
        return row * layout.layout[row].count + column
    }
    
    private func getKey(at index: Int) -> String? {
        // Implement your logic to retrieve the key at the given index from the keyboard layout
        // Return the corresponding key or nil if the index is out of range
        
        let flattenedLayout = layout.layout.flatMap { $0 }
        
        guard index >= 0, index < flattenedLayout.count else {
            return nil
        }
        
        return flattenedLayout[index]
    }
}
