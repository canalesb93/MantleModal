# Mantle Modal
Draggable Modal, PopUp or Menu
## Description
A simple modal resource that uses a UIScrollView to allow the user to close the modal by dragging it down.

<div align="center"><img src="http://imgur.com/tZr1ns4.gif" width=300></div>

## Install Instructions

#### CocoaPods
MantleModal is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!

target 'ProjectName' do
  pod 'MantleModal'
end
```

Then, run `pod install`

In case you haven't installed CocoaPods yet, run the following command

```ruby
$ gem install cocoapods
```

#### Manual
Drag the file named `RCMantleViewController.swift` into your project.

## Usage

Setup is faily simple, but I have plans to make it even easier later.
### Step 1
Add a new View Controler into your storyboard and set the **Class** to `RCMantleViewController` and the **Storyboard ID** to `MantleViewController`.

<div align="center"><img src="http://imgur.com/bWINRWy.png" width=300></div>
### Step 2
Add your own view into your storyboard which will represent the modal. Also set a unique **Storyboard ID** to it.
<div align="center"><img src="http://imgur.com/R3P0fN4.png"></div>
If you are gonna use a PopUp set the background view color transparent.

### Step 3 
Import the module to your parent controller(if your using CocoaPods)

```swift
  import MantleModal
```

Activate the modal like this in your parent controller.

```swift
  // Create the MantleViewController from the Storyboard using the ID
  let mantleViewController = storyboard!.instantiateViewControllerWithIdentifier("MantleViewController") as! RCMantleViewController
  // Create your modal controller with your storyboard ID
  let popUpViewController = storyboard!.instantiateViewControllerWithIdentifier("YourUniqueStoryboardID") as! YourViewController
  // Set it's delegate to be able to call 'delegate.dismissView(animated: Bool)'
  popUpViewController.delegate = mantleViewController
  // Initialize Mantle
  mantleViewController.setUpScrollView()
  // Add your modal to Mantle
  mantleViewController.addToScrollViewNewController(popUpViewController)
  // Present the modal through the MantleViewController
  self.presentViewController(mantleViewController, animated: false, completion: nil)
```
### Step 4
In your modal's controller also import:

```swift
  import MantleModal
```

Then define your delegate helper.

```swift
  var delegate: RCMantleViewDelegate!
```
And then dismiss the modal using this:

```swift
  delegate.dismissView(true)
```

## Options
MantleModal currently includes some configuration which you must call before `mantleViewController.setUpScrollView()`.
The current configuration available includes:

```swift

  // Allows you to dismiss the view by dragging up
  mantleViewController.bottomDismissible = false
  // Allows you to dismiss the view by dragging down
  mantleViewController.topDismissable = true
  // Allows you to drag to the sides to close
  mantleViewController.draggableToSides = false

  // 'appearOffset' moves the menu closer to the edge so that it appears quicker
  mantleViewController.appearOffset = CGFloat(290)
  // '290' could be the distance between the top of the popup and the top of the screen 
  
  // Makes the view present from the top, can be set multiple times before presenting
  // Also makes it hide to the top.
  mantleViewController.appearFromTop = true // // default = false
```

You can also access the ScrollView and modify its options, just make sure you do it after calling `mantleViewController.setUpScrollView()`

```swift
  mantleViewController.scrollView.bounces = false
```

## Credits

Mostly done by myself - **Ricardo Canales**

Initial code inspired by this [StackOverflow](http://stackoverflow.com/questions/24687140/snapchat-like-swipe-navigation-between-views-in-xcode-6-and-swift) post.
Credit to [lbrendanl](https://github.com/lbrendanl) and [Poql](http://stackoverflow.com/users/3857555/poql)



