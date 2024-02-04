import SwiftUI

struct FractalView: View {
    @Binding var scale: CGFloat
    @Binding var offset: CGSize
    @Binding var complexity: CGFloat // For dynamic complexity adjustment
    @Binding var highlightedAreas: [CGRect] // For visual feedback based on gaze analysis
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Path { path in
                    let center = CGPoint(x: geometry.size.width / 2 + offset.width, y: geometry.size.height / 2 + offset.height)
                    var angle = CGFloat(0)
                    let endAngle = CGFloat(2 * Double.pi)
                    // Adjust the step based on complexity for a more detailed or simplified pattern
                    let step = (CGFloat.pi / 60) * complexity
                    
                    while angle < endAngle {
                        // Complexity affects the radius to create more or less intricate patterns
                        let radius = (50 * scale + angle * scale) * complexity
                        let point = CGPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius)
                        if angle == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                        angle += step
                    }
                    path.closeSubpath()
                }
                .stroke(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                .scaleEffect(scale)
                .offset(offset)
            }
            .animation(.easeInOut, value: scale) // Animating scale changes
            .animation(.easeInOut, value: offset) // Animating offset changes
            
            // Highlighting areas of interest
            ForEach(Array(highlightedAreas.enumerated()), id: \.offset) { _, area in
                Path { path in
                    path.addRect(area)
                }
                .stroke(Color.blue, lineWidth: 3) // Highlight with a blue outline
                .animation(.easeInOut, value: area) // Animating the appearance of highlights
            }
        }
    }
}
