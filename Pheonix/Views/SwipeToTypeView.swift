//This file defines a SwiftUI view called SwipeToTypeView that enables swipe-to-type functionality. Let's break down the implementation:

//The SwipeToTypeView struct is declared, conforming to the View protocol in SwiftUI.
//It contains a single property:
//swipeToTypeController: An ObservedObject property that holds the instance of SwipeToTypeController responsible for managing the swipe-to-type functionality.
//The body property describes the view's content using a TextEditor component.
//The TextEditor displays an editable text area bound to the text property of the swipeToTypeController.
//The view sets up a DragGesture gesture on the TextEditor.
//When the gesture changes (i.e., user is swiping), it checks if the swipe direction is to the left by comparing the startLocation and location coordinates of the gesture.
//If the swipe is to the left, it calls the handleSwipeGesture method on the swipeToTypeController using a UISwipeGestureRecognizer.
//This enables the swipe gesture to be handled by the SwipeToTypeController, triggering the appropriate action.
//Overall, this file defines a SwiftUI view that allows users to perform swipe gestures to enable swipe-to-type functionality. The swipe gestures are detected and passed to the SwipeToTypeController for further processing and handling.

import SwiftUI

struct SwipeToTypeView: View {
    @ObservedObject var swipeToTypeController: SwipeToTypeController
    
    var body: some View {
        TextEditor(text: $swipeToTypeController.text)
            .gesture(DragGesture().onChanged { value in
                if value.startLocation.x > value.location.x {
                    // Swipe left detected
                    self.swipeToTypeController.handleSwipeGesture(UISwipeGestureRecognizer())
                }
            })
    }
}
