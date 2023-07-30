import UIKit

// Marking AppDelegate class as the application's delegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // UIWindow object that describes and manages the app’s visual content
    var window: UIWindow?

    // AppDelegate's method that is called once when the application has finished launching, it is where initial setup should occur
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialising UIWindow object
        window = UIWindow()
        // Creating an instance of Keyboard
        let keyboardViewController = Keyboard() 
        // Setting Keyboard instance as the root view controller of the window
        window?.rootViewController = keyboardViewController
        // Making the receiver the main window, and making it visible
        window?.makeKeyAndVisible()
        // Returning true from didFinishLaunchingWithOptions method tells the system that the app is ready to run
        return true
    }
}
