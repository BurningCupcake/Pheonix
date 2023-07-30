import UIKit

// The starting point for every iOS app. Executes your app’s startup sequence. 
UIApplicationMain(

    // Number of arguments that are passed to the app on launch.
    CommandLine.argc,

    // The actual arguments passed to the app on launch.
    CommandLine.unsafeArgv,

    // The name of the principal class that handles application lifecycle events.
    // In this case it's `nil`, so the default UIApplication class will be used.
    nil,

    // The name of the AppDelegate class. The AppDelegate is a central place to handle 
    // application-level events - like app launch, state transition, etc.
    NSStringFromClass(AppDelegate.self)
)
