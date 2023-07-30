/// EyeMovementMonitor class for monitoring eye movement.
class EyeMovementMonitor {
    
    /// An instance of type 'EyeTracker' for keeping track of the user's eyes.
    var eyeTracker: EyeTracker
    
    /// Waiting function, Timer will do task repeatedly after a specific time interval.
    var timer: Timer?
    
    /// Array of type 'EyeMovement' for storing all the eye positions. Here we are using CGPoint for eye movements.
    var eyeMovements: [EyeMovement] = [] 

    /// Initializes an EyeMovementMonitor with given eyeTracker.
    /// - Parameter eyeTracker: The instance used to monitor users' eyes.
    init(eyeTracker: EyeTracker) {
        self.eyeTracker = eyeTracker
    }
        
    /// Start monitoring the users' eyes.
    func startMonitoring() {
        // To prevent any retain cycle, we use [weak self] in the closure of timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            // If self is nil or deallocated, the timer will stop firing
            guard let self = self else { return }
            let currentPosition = self.eyeTracker.currentPosition
            self.eyeMovements.append(currentPosition)
        }
    }
    
    /// Stop monitoring the users' eyes.
    /// Always invalidate Timer before setting it to nil to avoid memory leaks.
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
}
