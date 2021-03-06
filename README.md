![Meta iOS SDK](logo.png?raw=true "Meta iOS SDK")

# Meta iOS SDK

Render [Metaverse](https://gometa.io) experiences inside of your own app or framework. Build, test, and iterate with Metaverse Studio and Metaverse Browser, and then render in your own app.

[**Full Documentation**](https://gometa.github.io/meta-ios-sdk/Classes/Meta.html)

## Prerequisites

- Target iOS 9.3 or higher
- Create a Metaverse account and log in to [Metaverse Studio](https://studio.gometa.io)
- Install [`git-lfs`](https://git-lfs.github.com/) (this is a REQUIRED step!)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is required to install Meta. Install Cocoapods with the following command:

```bash
$ gem install cocoapods
```

To integrate Meta into your Xcode project using CocoaPods, specify it in your `Podfile`. Note that you must include the GoMeta private spec repo in your Podfile to install Meta.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/GoMeta/meta-ios-pods'

platform :ios, '9.3'
use_frameworks!

target '<Your Target Name>' do
    pod 'Meta'
end
```

Then, run the following command:

```bash
$ pod install --repo-update
```

## Configure App Privacy Settings

Metaverse experiences depend heavily on access to the Camera and device motion. Camera scenes that record video also require access to the microphone. Make sure your app's `Info.plist` file contains the following:

```xml
<key>NSCameraUsageDescription</key>
<string>Use your camera to experience augmented reality</string>
<key>NSMicrophoneUsageDescription</key>
<string>Use your microphone to record audio</string>
<key>NSMotionUsageDescription</key>
<string>Use device motion to experience augmented reality</string>
```

## Initialize SDK

Before loading any experience, apps must initialize Meta by calling `Meta.configure(withKey: "API_KEY")`. This should be done once, ideally from within your Application Delegate's `didFinishLaunchingWithOptions` method. You can find your API keys in Metaverse Studio on the [SDK Page](https://studio.gometa.io/sdk/keys).

```swift
import Meta
...

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    	// Initialize the Meta SDK
        Meta.configure(withKey: "api-test-xxxxxxx")

        return true
    }

}
```

## Present Experience

### Create an Experience object

Experiences are managed by `MetaExperience` objects. Initialize a new object with the experience ID, and optionally the delegate.

```swift
import Meta
import UIKit

class ViewController: UIViewController {

	var experience: MetaExperience!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.experience = MetaExperience(id: "EXPERIENCE_ID")
	}
}
```

### Present the experience

Show the experience in response to a user action.

```swift
@IBAction func doSomething(_ sender: AnyObject) {
	Meta.shared.present(experience: self.experience)
}
```

### Use MetaExperienceDelegate (optional)

If you want to be notified when an experience closes (for example, to only reward a user if they have completed the entire experience), implement `MetaExperienceDelegate`. Be sure to set the delegate property on your `MetaExperience` object (`self.experience.delegate = self`).

```swift
extension ViewController: MetaExperienceDelegate {
	func metaExperienceDidClose(withReason reason: MetaExperienceCloseReason) {
        if(reason == .completion) {
            // Do something if the user completed the experience
        } else {
            // The user manually closed the experience
        }
    }
}
```

## Identifying Users

If you would like to store persistent user data, use `Meta.shared.identify(user: "USER_ID")` to associate your app user with the Meta SDK. Identifying users allows you to do things like save and track user properties across experiences, and to give and request items from users’ inventories.

You can identify a user using some unique piece of information known by your application. For instance, if your app requires accounts, you can invoke this method at the time of sign in and provide your user ID as the argument (or, if you require unique usernames, the username; or another piece of information like phone number or email address) to create a persistent Metaverse account linked to their user profile within your app.

This method only needs to be invoked once. It writes the user’s identification key to your app’s UserDefaults, and references it when loading subsequent experiences.

Note that, at this time, if you are unable to identify a user, or choose not to, all Metaverse activity within your app will appear to be coming from the account associated with your API key. This is fine for testing, but might lead to collisions and weird things when dealing with items and user properties in production. We recommend at least identifying a user with a randomly generated UUID.

## Submitting to the App Store

The Meta SDK collects the IDFA, if advertising tracking is enabled by the user, in order to aggregate analytics data and share impression data with our content partners (e.g., Google Poly, Gfycat Stickers, etc.). When you submit your app to the app store, be sure to check the following boxes under the "Does this app use the Advertising Identifier (IDFA)?"" section:

- "Attribute this app installation to a previously served advertisement"
- "Attribute an action taken within this app to a previously served advertisement"
- "I, YOUR_NAME, confirm that this app, and any third party...""

**Note, you should not check the box labeled “Serve advertisements within the app” unless you are actually going to display ads.**

## Common issues

**Scene backgrounds not loading**

If a scene background references an image, iOS will block loading of that image unless it is served from an https URL. To allow loading of insecure images in scene backgrounds, you need to make sure your `Info.plist` contains the following:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## Sample Apps

The `Demo` folder of this repository contains four sample apps. Watch the [preview video](https://www.youtube.com/watch?v=yJdRIZD6N04) to see them in action.

- **SimpleDemo** shows how to launch an experience in response to a button press.
- **MetaNews** is a simple news reader that shows how display ads can render Metaverse experiences.
- **FlappyMeta** shows how Metaverse experiences can be used as Rewarded Interactive Ads inside of a game, requiring a user to complete an experience in order to keep playing.
- **MetaXCX** shows how apps can mix native content and embedded Metaverse experiences.

## Extras

If you create something awesome, we'd love to see it and feature it here! Create a PR on this Readme to add your project, or let us know about it via email (support@gometa.io) or Facebook/Twitter.
