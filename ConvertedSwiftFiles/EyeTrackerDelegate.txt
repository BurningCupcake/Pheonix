
import Foundation
import CoreGraphics

protocol EyeTrackerDelegate: AnyObject {
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint)
    func eyeTrackerDidStartTracking(_ eyeTracker: EyeTracker)
    func eyeTrackerDidStopTracking(_ eyeTracker: EyeTracker)
    // Add any additional delegate methods for eye tracking events
}
   

extension EyeTrackerDelegate {
    func eyeTracker(_ eyeTracker: EyeTracker, didTrackGazePoint gazePoint: CGPoint) {
        // Default implementation for tracking gaze point
        // You can override this method in conforming classes to handle the gaze point updates
    }
    
    func eyeTrackerDidStartTracking(_ eyeTracker: EyeTracker) {
        // Default implementation for starting gaze tracking
        // You can override this method in conforming classes to perform any necessary actions when tracking starts
    }
    
    func eyeTrackerDidStopTracking(_ eyeTracker: EyeTracker) {
        // Default implementation for stopping gaze tracking
        // You can override this method in conforming classes to perform any necessary actions when tracking stops
    }
}
