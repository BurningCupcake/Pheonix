import Foundation
import CoreGraphics

class GazeDataAnalyzer {
    var recentGazePoints: [CGPoint] = []
    let clusterThreshold: CGFloat = 50 // Threshold distance to consider points in the same cluster
    
    // Adds a new gaze point to the collection, maintaining a fixed size for smoothing
    func addGazePoint(_ point: CGPoint) {
        recentGazePoints.append(point)
        if recentGazePoints.count > 20 { // Adjust based on your needs
            recentGazePoints.removeFirst()
        }
    }
    
    // Calculates a smoothed gaze point from the recent collection of gaze points
    func getSmoothedGazePoint() -> CGPoint {
        let sum = recentGazePoints.reduce(CGPoint.zero) { $0 + CGPoint(x: $1.x, y: $1.y) }
        return CGPoint(x: sum.x / CGFloat(recentGazePoints.count), y: sum.y / CGFloat(recentGazePoints.count))
    }
    
    // Analyzes a gaze point against the fractal bounds and determines scale and offset adjustments
    func analyzeGazePoint(_ gazePoint: CGPoint, fractalBounds: CGRect) -> (scaleAdjustment: CGFloat, offsetAdjustment: CGSize) {
        let smoothedPoint = getSmoothedGazePoint()
        let scaleAdjustment = smoothedPoint.isNearEdge(of: fractalBounds) ? 0.1 : -0.05
        let offsetAdjustment = CGSize(width: smoothedPoint.x - fractalBounds.midX, height: smoothedPoint.y - fractalBounds.midY)
        return (scaleAdjustment, offsetAdjustment)
    }
    
    // Detects clusters of gaze points indicating areas of interest
    func detectInterestAreas() -> [CGRect] {
        var clusters: [[CGPoint]] = []
        for point in recentGazePoints {
            var foundCluster = false
            for (index, cluster) in clusters.enumerated() {
                if cluster.contains(where: { $0.distance(to: point) < clusterThreshold }) {
                    clusters[index].append(point)
                    foundCluster = true
                    break
                }
            }
            if !foundCluster {
                clusters.append([point])
            }
        }
        
        // Convert clusters to CGRects representing areas of interest
        return clusters.map { cluster in
            let minX = cluster.min(by: { $0.x < $1.x })?.x ?? 0
            let maxX = cluster.max(by: { $0.x < $1.x })?.x ?? 0
            let minY = cluster.min(by: { $0.y < $1.y })?.y ?? 0
            let maxY = cluster.max(by: { $0.y < $1.y })?.y ?? 0
            return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
        }
    }
}

// Extension to aid in determining if a point is near the edge of a given rectangle and calculating distance between points
extension CGPoint {
    func isNearEdge(of rect: CGRect, threshold: CGFloat = 20) -> Bool {
        return x - rect.minX < threshold || rect.maxX - x < threshold || y - rect.minY < threshold || rect.maxY - y < threshold
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - self.x), 2) + pow((point.y - self.y), 2))
    }
}
