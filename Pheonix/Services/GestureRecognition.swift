import UIKit
import Vision

class GestureRecognition {
    weak var delegate: GestureRecognitionDelegate?
    private let gestureClassifier: GestureClassifier
    
    init(gestureClassifier: GestureClassifier) {
        self.gestureClassifier = gestureClassifier
    }
    
    func processGesture(image: UIImage) {
        guard let cgImage = image.cgImage else {
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest(completionHandler: handleGestureRecognition)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Error processing gesture: \(error)")
        }
    }
    
    private func handleGestureRecognition(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        var recognizedGesture: Gesture?
        
        for result in results {
            guard let topCandidate = result.topCandidates(1).first else {
                continue
            }
            
            if gestureClassifier.isGesture(topCandidate.string) {
                recognizedGesture = Gesture(name: topCandidate.string)
                break
            }
        }
        
        delegate?.gestureRecognition(self, didRecognizeGesture: recognizedGesture)
    }
}
