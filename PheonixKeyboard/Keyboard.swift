import Foundation
import SwiftUI
import ARKit

class Keyboard: UIInputViewController, GazeDetectionDelegate, KeyboardInteractionDelegate, SwipeToTypeControllerDelegate {
    
    private var keyboardHostingController: UIHostingController<KeyboardView>!
    private var gazeDetection: GazeDetection!
    private var dynamicCalibration: DynamicCalibration!
    private var keyboardInteraction: KeyboardInteraction!
    private var textEntry: TextEntry!
    private var eyeTracker: EyeTracker!
    private var swipeToTypeController: SwipeToTypeController!
    private let textEntryService = TextEntryService()
    private var keyboardView: KeyboardView!
    @ObservedObject private var spellingIndicatorWrapper = SpellingIndicatorDelegateWrapper()
    private var interfaceOrientation: UIInterfaceOrientation = .portrait // Create a new property to keep track of the interface orientation
    
    private let textChecker = UITextChecker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicCalibration = DynamicCalibration()
        gazeDetection = GazeDetection(calibrationDelegate: dynamicCalibration)
        keyboardInteraction = KeyboardInteraction(layout: KeyboardLayout.defaultLayout(), textEntryService: textEntryService)
        textEntry = TextEntry()
        eyeTracker = EyeTracker()
        swipeToTypeController = SwipeToTypeController()
        
        gazeDetection.delegate = self
        keyboardInteraction.delegate = self
        swipeToTypeController.delegate = self
        
        let delegateWrapper = KeyboardViewDelegateWrapper(spellingIndicator: spellingIndicatorWrapper.spellingIndicator)
        let keyboardView = KeyboardView(delegateWrapper: delegateWrapper, wordSuggestions: $spellingIndicatorWrapper.wordSuggestions, spellingIndicator: $spellingIndicatorWrapper.spellingIndicator, keyboardLayout: KeyboardLayout.defaultLayout())
        self.keyboardView = keyboardView
        
        keyboardHostingController = UIHostingController(rootView: keyboardView)
        keyboardHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(keyboardHostingController)
        view.addSubview(keyboardHostingController.view)
        keyboardHostingController.didMove(toParent: self)
        
        if let keyboardContentView = keyboardHostingController.view.subviews.first {
            swipeToTypeController.attach(to: keyboardContentView)
        }
        
        gazeDetection.start()
        eyeTracker.startTracking()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        keyboardHostingController.view.frame = view.bounds
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.interfaceOrientation = self.view.window?.windowScene?.interfaceOrientation ?? .unknown
        })
    }
    
    // MARK: - GazeDetectionDelegate
    
    func gazeDetection(_ gazeDetection: GazeDetection, didDetectGazeAt point: CGPoint) {
        keyboardInteraction.processGazePoint(point)
    }
    
    // MARK: - KeyboardInteractionDelegate
    
    func didSelectKey(_ key: String) {
        let result = textEntryService.addCharacter(key)
        switch result {
            case .success(let state):
                print("New state: \(state)")
                
                let completions = getWordCompletions(for: state.text)
                DispatchQueue.main.async {
                    self.spellingIndicatorWrapper.updateWordSuggestions(completions)
                }
                
                // Perform spell checking
                let isSpellingCorrect = performSpellChecking(for: state.text)
                DispatchQueue.main.async {
                    self.spellingIndicatorWrapper.spellingIndicator = isSpellingCorrect
                }
                
            case .failure(let error):
                print("Error adding character: \(error)")
        }
    }
    
    // MARK: - Word Completions
    
    private func getWordCompletions(for text: String) -> [String] {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let completions = textChecker.completions(forPartialWordRange: range, in: text, language: "en_US")
        return completions ?? []
    }
    
    // MARK: - Spell Checking
    
    private func performSpellChecking(for text: String) -> Bool {
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: range, startingAt: 0, wrap: false, language: "en_US")
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - SwipeToTypeControllerDelegate
    
    func didSwipeLeft() {
        // Handle the swipe left event
        // You can perform the swipe-to-type action here
    }
}
