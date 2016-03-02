# Swift Off :rocket:
[![Build Status](https://travis-ci.org/goprimer/swift-off.svg?branch=master)](https://travis-ci.org/goprimer/swift-off)

Swift Off is a boilerplate project for Xcode which makes it easy to get started building an iOS app using Swift. It's a great starting point for any new app. We've already included several standard SDKs and setup all the boring stuff, so you can just focus on building the core of your app!

### What's already built for you:
- Ideal Swift App Structure
- Base Storyboard and Navigation Bar
- Beautiful, easy to use UI with [Material](https://github.com/CosmicMind/Material)
- Analytics Tracking and Integrations with [Segment](https://segment.com)
- Customizable Signup (Email, Facebook, or Phone #) and Login with [Primer](https://goprimer.com)
- User (+More) Account Storage with [Firebase](https://www.firebase.com/)
- Crash & Error Reporting with [Rollbar](https://rollbar.com/)
- Elegant HTTP interaction with [Alamofire](https://github.com/Alamofire/Alamofire)
- Functional tool-belt for Swift with [Dollar](https://github.com/ankurp/Dollar)
- Ability to easily include future SDKs with [Cocoapods](https://cocoapods.org/)

We put this together because we wanted a great starting point for working on side projects or test apps. We also got tired of rebuilding all this stuff ourselves and thought it was a great way to showcase the correct structure of a standard Swift app.

## Requirements

#### Cocoapods
You'll need to have Cocoapods installed on your computer to install the external SDKs. Trust us, it's one of the best ways to manage external SDKs in your app.

```sh
sudo gem install cocoapods
```

You'll need CocoaPods version 0.36+, so if you're using an older version, you can update by running the command above. More installation instructions can be found [here](https://guides.cocoapods.org/using/getting-started.html#getting-started).

#### Xcode 7.2+

## Getting Started

#### Download the Project
Download the Swift Off boilerplate app by using the [zip](archive/master.zip).

#### Rename your project
Of course you want the app to be named something awesome! You can easily rename the Swift Off template app to whatever you want.

In this example let's assume you are naming your app: **Kitty Clothes**

1. Unzip `swift-off-master.zip` and rename the folder to `kitty-clothes`.
2. Open your `Swift Off.xcproject` file in Xcode (inside `kitty-clothes/`).
3. Follow Apple's [guide to renaming projects](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/RenamingaProject/RenamingaProject.html).
4. Rename your Bundle Identifier in XCode settings.
5. Quit Xcode.
6. Update your Podfile target:

  Use terminal (`vim Podfile`) or your favorite text editor:

    Change: `target 'Swift Off' do` to `target 'Kitty Clothes' do`

#### Create XCode Workspace
Cocoapods creates a .xcworkspace which includes all the required SDKs bundled with your future app!

```sh
cd kitty-clothes/
pod install
open Kitty\ Clothes.xcworkspace
```

This will install the required libraries, create your xcworkspace and then open it in Xcode. You can also open the .xcworkspace file directly from Xcode.

Make sure you are opening the .xcworkspace and not your .xcproject or else you're gonna have a bad time.

#### Get Firebase Token
Before you can run your app, you are required to have a free Firebase token. To get one, you'll need to go to https://firebase.com and signup for an account.

#### Launch Kitty Clothes
You're done! Now press the Play button in Xcode to build and run your project using one of the Simulators.

You should see a cute Kitten greeting you on your Install screen with options to signup or login. Once you go through the Signup flow, you'll see your application running with a navigation bar and side menu.

## What's Next?
Now you can get to work building your amazing app!

We've written a tutorial on how to build... and you can find it...

## Live Apps built with Swift Off
None yet :cry:. Is your app live and built from Swift Off? Create a PR and add it here!
