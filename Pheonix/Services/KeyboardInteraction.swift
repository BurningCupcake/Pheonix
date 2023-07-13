import UIKit

protocol KeyboardInteractionDelegate: class {
    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String)
}

class KeyboardInteraction {
    private let layout: KeyboardLayout
    weak var delegate: KeyboardInteractionDelegate?
    
    init(layout: KeyboardLayout) {
        self.layout = layout
    }
    
    func processGazePoint(_ point: CGPoint) {
        let keyIndex = calculateKeyIndex(at: point)
        if let key = getKey(at: keyIndex) {
            delegate?.keyboardInteraction(self, didSelectKey: key)
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
