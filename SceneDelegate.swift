import UIKit
import SwiftUI

// SceneDelegate class which inherits UIResponder and implements UIWindowSceneDelegate protocol
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // UIWindow instance variable. A type of optional UIWindow
    var window: UIWindow?
    
    // This function is the entry point of the app, creates the UIWindowScene and launches the UIHostingController with ContentView as the root view.
    // This function is automatically launched whenever a new scene(session) is created.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // We securely bind UIWindowScene from the given scene, if the casting fails, the function will return and do nothing
        guard let windowScene = scene as? UIWindowScene else { return }
        
        // Initialize new UIWindow with the given windowScene
        let window = UIWindow(windowScene: windowScene)
        
        // Assign UIHostingController (which has ContentView as rootView) to rootViewController of our UIWindow
        window.rootViewController = UIHostingController(rootView: ContentView())
        
        // Assign our newly created UIWindow to the instance variable
        self.window = window
        
        // Make this window the main window and make it visible
        window.makeKeyAndVisible()
    }
}
