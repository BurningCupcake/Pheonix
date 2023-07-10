import UIKit

class KeyboardKey: UIView {
    
    var gazeIndicator: UIView
    weak var delegate: KeyboardViewDelegate?
    let textEntryService: TextEntryService  // Add a property for the text entry service
    
    static let defaultLayout = [
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
        ["K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"],
        ["U", "V", "W", "X", "Y", "Z", ".", ",", "?", "!"]
    ]
    
    init(textEntryService: TextEntryService) {  // Add the textEntryService parameter to the initializer
        self.textEntryService = textEntryService
        self.gazeIndicator = UIView()
        super.init(frame: .zero)
        setupGazeIndicator()
        setupKeyboardLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupGazeIndicator() {
        gazeIndicator.backgroundColor = UIColor.red
        gazeIndicator.frame.size = CGSize(width: 20, height: 20)
        gazeIndicator.layer.cornerRadius = 10
        addSubview(gazeIndicator)
    }
    
    func updateGazeIndicatorPosition(_ position: CGPoint) {
        gazeIndicator.center = position
    }
    
    let keySize = CGSize(width: 40, height: 40)
    let keyPadding: CGFloat = 5
    
    func setupKeyboardLayout() {
        for (i, row) in KeyboardKey.defaultLayout.enumerated() {
            for (j, key) in row.enumerated() {
                let keyLabel = UILabel()
                keyLabel.text = key
                keyLabel.textAlignment = .center
                keyLabel.backgroundColor = UIColor(white: 0.95, alpha: 1)
                keyLabel.layer.cornerRadius = 8
                keyLabel.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectKey(_:)))
                keyLabel.addGestureRecognizer(tapGesture)
                
                let xPos = keyPadding + CGFloat(j) * (keySize.width + keyPadding)
                let yPos = keyPadding + CGFloat(i) * (keySize.height + keyPadding)
                keyLabel.frame = CGRect(x: xPos, y: yPos, width: keySize.width, height: keySize.height)
                
                addSubview(keyLabel)
            }
        }
    }
    
    @objc func didSelectKey(_ sender: UITapGestureRecognizer) {
        if let keyLabel = sender.view as? UILabel, let key = keyLabel.text {
            delegate?.didSelectKey(key, textEntryService: textEntryService)  // Pass the textEntryService argument
        }
    }
}

