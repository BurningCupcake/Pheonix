import SwiftUI

struct SwipeToTypeView: View {
    @ObservedObject var swipeToTypeController: SwipeToTypeController
    
    var body: some View {
        TextEditor(text: $swipeToTypeController.text)
            .gesture(DragGesture()
                .onChanged { value in
                    let deltaX = value.location.x - value.startLocation.x
                    let deltaY = value.location.y - value.startLocation.y
                    
                    if abs(deltaX) > abs(deltaY) {
                        if deltaX > 0 {
                            swipeToTypeController.handleSwipeGesture(delta: deltaX, direction: .right)
                        } else {
                            swipeToTypeController.handleSwipeGesture(delta: -deltaX, direction: .left)
                        }
                    } else {
                        if deltaY > 0 {
                            swipeToTypeController.handleSwipeGesture(delta: deltaY, direction: .down)
                        } else {
                            swipeToTypeController.handleSwipeGesture(delta: -deltaY, direction: .up)
                        }
                    }
                }
            )
    }
}
