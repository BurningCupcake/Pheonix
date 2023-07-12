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
