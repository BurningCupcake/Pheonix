class EyeMovementMonitor {
    var eyeTracker: EyeTracker
    var timer: Timer?
    var eyeMovements: [EyeMovement] = []
    
    init(eyeTracker: EyeTracker) {
        self.eyeTracker = eyeTracker
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let currentPosition = self.eyeTracker.currentPosition
            self.eyeMovements.append(currentPosition) // Assuming EyeMovement is CGPoint
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
}
