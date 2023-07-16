//The provided code defines a KeyboardInteraction class responsible for handling user interactions with a keyboard based on the gaze point. Here's the analysis of the code:

//The KeyboardInteraction class has the following properties:
//layout: A KeyboardLayout object representing the layout of the keyboard.
//delegate: A weak reference to an object conforming to the KeyboardInteractionDelegate protocol. The delegate will receive updates when a key is selected.
//textEntryService: An instance of TextEntryService to perform text entry operations.
//The init(layout:textEntryService:) initializer initializes the KeyboardInteraction object with the provided keyboard layout and text entry service.
//The processGazePoint(_:) function is responsible for processing the gaze point and determining the key that is being focused on. It performs the following steps:
//Calculates the index of the key based on the gaze point by calling the calculateKeyIndex(at:) method.
//Retrieves the key at the calculated index by calling the getKey(at:) method.
//Notifies the KeyboardInteractionDelegate of the selected key via the didSelectKey(_:textEntryService:) method, passing the key and the text entry service as arguments.
//The calculateKeyIndex(at:) method calculates the index of the key based on the provided point. It determines the row and column of the key in the keyboard layout and computes the index accordingly.
//The getKey(at:) method retrieves the key at the specified index. It flattens the keyboard layout into a single array of keys and performs bounds checking to ensure the index is within the valid range.
//Note: The code assumes that the KeyboardInteractionDelegate protocol is implemented by another object that will receive updates when a key is selected. Additionally, the KeyboardLayout and TextEntryService classes are assumed to be defined elsewhere.

import Foundation

class KeyboardInteraction {
    private let layout: KeyboardLayout
    weak var delegate: KeyboardInteractionDelegate?
        let textEntryService: TextEntryService // Add this property to hold the instance of TextEntryService
    
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

