import UIKit
import SwiftUI

// SceneDelegate class which inherits UIResponder and implements UIWindowSceneDelegate protocol
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // UIWindow instance variable. A type of optional UIWindow
    var window: UIWindow?
    
    // This function is the entry point of the app, creates the UIWindowScene and launches the UIHostingController with ContentView as the root view.
    // This function is automatically launched whenever a new scene(session) is created.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is of type UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create a new UIWindow using the windowScene constructor which takes the UIWindowScene as a parameter
        let window = UIWindow(windowScene: windowScene)
        
        // Create the SwiftUI view that provides the window contents
        let contentView = ContentView() // Replace ContentView with your initial SwiftUI view
        
        // Use a UIHostingController as window root view controller to host the SwiftUI view
        window.rootViewController = UIHostingController(rootView: contentView)
        
        // Set the window and make it visible
        self.window = window
        window.makeKeyAndVisible()
    }
}
