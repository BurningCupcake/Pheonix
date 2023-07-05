import SwiftUI


struct KeyboardView: View {
    var keyboardInteraction: KeyboardInteraction
    weak var delegate: KeyboardViewDelegate?
    
    var keyboardLayout: KeyboardLayout = KeyboardLayout.defaultLayout()
    
    var body: some View {
        VStack {
            Text("Keyboard View")
                .font(.title)
                .padding()
            
            // Add keys based on the keyboard layout and interaction
            ForEach(keyboardLayout.layout.indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(keyboardLayout.layout[rowIndex].indices, id: \.self) { columnIndex in
                        Text(keyboardLayout.layout[rowIndex][columnIndex])
                            .tag(rowIndex * keyboardLayout.layout[rowIndex].count + columnIndex)
                            .onTapGesture {
                                let key = keyboardLayout.layout[rowIndex][columnIndex]
                                delegate?.didSelectKey(key)
                            }
                    }
                }
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(keyboardInteraction: KeyboardInteraction(layout: KeyboardLayout.defaultLayout()), delegate: nil)
    }
}
