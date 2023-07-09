class EyeGazeViewController: UIViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, WordSuggestionDelegate {
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var wordSuggestion: WordSuggestion!
    private var eyeTrackingController: EyeTrackingController!
    private var keyboardView: KeyboardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardView.defaultLayout)
        textEntry = TextEntry()
        wordSuggestion = WordSuggestion()
        eyeTrackingController = EyeTrackingController()

        gazeDetection.delegate = self
        dynamicCalibration.delegate = eyeTrackingController
        keyboardInteraction.delegate = textEntry
        wordSuggestion.delegate = eyeTrackingController

        keyboardView = KeyboardView()
        keyboardView.delegate = keyboardInteraction
        keyboardView.backgroundColor = .lightGray

        view.addSubview(keyboardView)

        gazeDetection.start()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        keyboardView.frame = view.bounds
    }

    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }

    func keyboardInteraction(_ keyboardInteraction: KeyboardInteraction, didSelectKey key: String) {
        textEntry.keyboardInteraction(keyboardInteraction, didSelectKey: key)
        wordSuggestion.processTextEntry(textEntry)
    }

    func wordSuggestion(_ wordSuggestion: WordSuggestion, didSuggestWords words: [String]) {
        keyboardView.updateWordSuggestions(words)
    }
}
