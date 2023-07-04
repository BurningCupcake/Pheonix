import UIKit

class KeyboardKey: UIView {
    
    var gazeIndicator: UIView
    weak var delegate: KeyboardViewDelegate?
    
    static let defaultLayout = [
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"],
        ["K", "L", "M", "N", "O", "P", "Q", "R", "S", "T"],
        ["U", "V", "W", "X", "Y", "Z", ".", ",", "?", "!"]
    ]
    
    init() {
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
        for (i, row) in KeyboardView.defaultLayout.enumerated() {
            for (j, key) in row.enumerated() {
                let keyButton = KeyboardKey()
                keyButton.setTitle(key, for: .normal)
                keyButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
                keyButton.layer.cornerRadius = 8
                keyButton.addTarget(self, action: #selector(didSelectKey(_:)), for: .touchUpInside)
                
                let xPos = keyPadding + CGFloat(j) * (keySize.width + keyPadding)
                let yPos = keyPadding + CGFloat(i) * (keySize.height + keyPadding)
                keyButton.frame = CGRect(x: xPos, y: yPos, width: keySize.width, height: keySize.height)
                
                addSubview(keyButton)
            }
        }
    }
    
    @objc func didSelectKey(_ sender: UIButton) {
        if let key = sender.titleLabel?.text {
            delegate?.keyboardView(self, didSelectKey: key)
        }
    }
}
