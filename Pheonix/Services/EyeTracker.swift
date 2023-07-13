import AVFoundation

class EyeTracker {
    weak var delegate: EyeTrackerDelegate?
    private var captureSession: AVCaptureSession?
    private var videoDataOutput: AVCaptureVideoDataOutput?
    private var eyeDetectionQueue: DispatchQueue = DispatchQueue(label: "com.yourapp.eyeDetectionQueue")
    
    init() {
        setupCaptureSession()
    }
    
    private func setupCaptureSession() {
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let irCamera = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front) else {
            // Failed to retrieve the front camera or IR camera
            return
        }
        
        do {
            let frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            let irCameraInput = try AVCaptureDeviceInput(device: irCamera)
            
            let captureSession = AVCaptureSession()
            captureSession.beginConfiguration()
            
            if captureSession.canAddInput(frontCameraInput) && captureSession.canAddInput(irCameraInput) {
                captureSession.addInput(frontCameraInput)
                captureSession.addInput(irCameraInput)
                
                let videoDataOutput = AVCaptureVideoDataOutput()
                videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
                videoDataOutput.alwaysDiscardsLateVideoFrames = true
                
                if captureSession.canAddOutput(videoDataOutput) {
                    captureSession.addOutput(videoDataOutput)
                    videoDataOutput.setSampleBufferDelegate(self, queue: eyeDetectionQueue)
                }
                
                captureSession.commitConfiguration()
                captureSession.startRunning()
                
                self.captureSession = captureSession
                self.videoDataOutput = videoDataOutput
            }
        } catch {
            // Error setting up the capture session
            print("Failed to set up the capture session: \(error.localizedDescription)")
        }
    }
}

extension EyeTracker: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Process the sample buffer to extract gaze point and eye state information
        // Implement your eye tracking algorithm here
        
        // Example implementation:
        let gazePoint = CGPoint(x: 0.5, y: 0.5) // Placeholder gaze point
        delegate?.eyeTracker(self, didTrackGazePoint: gazePoint)
        
        let eyeState = EyeState.open // Placeholder eye state
        delegate?.eyeTracker(self, didUpdateEyeState: eyeState)
    }
}
