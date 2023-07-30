// Import the SwiftUI library
import SwiftUI

// Define a SwiftUI View named SwipeToTypeView
struct SwipeToTypeView: View {
    // Declare an observed SwipeToTypeController object
    @ObservedObject var swipeToTypeController: SwipeToTypeController
    
    // Define the body of the SwiftUI View
    var body: some View {
        // Create a text editor bound to the text property of the SwipeToTypeController
        TextEditor(text: $swipeToTypeController.text)
            // Apply a gesture recognizer to the text editor
            .gesture(DragGesture()
                .onChanged { value in
                    // Calculate the horizontal and vertical displacement of the swipe
                    let deltaX = value.location.x - value.startLocation.x
                    let deltaY = value.location.y - value.startLocation.y
                    
                    // Determine if the swipe was primarily horizontal or vertical
                    if abs(deltaX) > abs(deltaY) {
                        // Handle horizontal swipe
                        if deltaX > 0 {
                            // Handle swipe to the right
                            self.swipeToTypeController.handleSwipeGesture(delta: deltaX, direction: .right)
                        } else {
                            // Handle swipe to the left
                            self.swipeToTypeController.handleSwipeGesture(delta: -deltaX, direction: .left)
                        }
                    } else {
                        // Handle vertical swipe
                        if deltaY > 0 {
                             // Handle swipe downward
                            self.swipeToTypeController.handleSwipeGesture(delta: deltaY, direction: .down)
                        } else {
                            // Handle swipe upward
                            self.swipeToTypeController.handleSwipeGesture(delta: -deltaY, direction: .up)
                        }
                    }
                })
    }
}
