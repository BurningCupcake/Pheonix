import Foundation
import CoreGraphics

// This protocol defines a set of methods that are called in response to eye tracking events.
protocol EyeTrackerDelegate: AnyObject {
    
    // This funtion is called when a new gaze point is tracked.
    // It receives the EyeTracker instance that is tracking the gaze and the CGPoint object representing the gaze point.
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint)
    
    // This function is called when the eye tracker starts tracking the eye movements.
    // It receives the EyeTracker instance that has started tracking.
    func eyeTrackerDidStartTracking(_ eyeTracker: EyeTracker)
    
    // This funtion is called when the eye tracker stops tracking the eye movements.
    // It receives the EyeTracker instance that has stopped tracking.
    func eyeTrackerDidStopTracking(_ eyeTracker: EyeTracker)
    
    
    
    // Any additional delegate methods for eye tracking events can be added here...
}
   

extension EyeTrackerDelegate {
    
    // Default implementation for the new method
    func eyeTrackerDidFailToStart(_ eyeTracker: EyeTracker) {
        // This method can be overridden in classes that conform to the EyeTrackerDelegate protocol
        // to define their own behavior when the eye tracking fails to start.
    }
    
    // Default implementation for tracking gaze point
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        // This method can be overridden in classes that conform to the EyeTrackerDelegate protocol
        // to define their own behavior when a gaze point is tracked.
    }
    
    // Default implementation for starting gaze tracking
    func eyeTrackerDidStartTracking(_ eyeTracker: EyeTracker) {
        // This method can be overridden in classes that conform to the EyeTrackerDelegate protocol
        // to define their own behavior when the eye tracking starts.
    }
    
    // Default implementation for stopping gaze tracking
    func eyeTrackerDidStopTracking(_ eyeTracker: EyeTracker) {
        // This method can be overridden in classes that conform to the EyeTrackerDelegate protocol
        // to define their own behavior when the eye tracking stops.
    }
}
