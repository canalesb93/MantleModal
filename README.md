# Mantle Modal
Made by Ricardo Canales
___
## Description
A simple modal resource that uses a UIScrollView to allow the user to close the modal by dragging it down.

![](http://imgur.com/tZr1ns4.gif)

## Install Instructions
#### CocoaPod
*Pending...*
#### Manual
Drag the file named `RCMantleViewController.swift` into your project.

## Setup
Setup is faily simple, but I have plans to make it even easier later.
### Step 1
Add a new ViewControler into your storyboard and set the **Class** to `RCMantleViewController` and the **Storyboard ID** to `MantleViewController`.
![image](http://imgur.com/bWINRWy.png)
### Step 2
Add your own view into your storyboard which will represent the modal. Also set a unique **Storyboard ID** to it.
![image](http://imgur.com/R3P0fN4.png)

### Step 3 
Activate the modal like this.
```swift
    @IBAction func presentModal(sender: AnyObject) {
        
        // Create the MantleViewController from the Storyboard using the ID
        let mantleViewController = storyboard!.instantiateViewControllerWithIdentifier("MantleViewController") as! RCMantleViewController
        // Create your modal controller
        let popUpViewController = storyboard!.instantiateViewControllerWithIdentifier("PopUpViewController") as! RCPopUpViewController
        // Set it's delegate to be able to call 'delegate.dismissView(animated: Bool)'
        popUpViewController.delegate = mantleViewController
        // Initialize Mantle
        mantleViewController.setUpScrollView()
        // Add your modal to Mantle
        mantleViewController.addToScrollViewNewController(popUpViewController)
        // Present the modal through the MantleViewController
        self.presentViewController(mantleViewController, animated: false, completion: nil)
    }
```
### Step 4
In your modals controller set 
```swift
    var delegate: RCMantleViewDelegate!
```
And then dismiss the modal with:
```swift
    delegate.dismissView(true)
```

## Credits
Mostly done by myself - **Ricardo Canales**

Initial code inspired by this [StackOverflow](http://stackoverflow.com/questions/24687140/snapchat-like-swipe-navigation-between-views-in-xcode-6-and-swift) post.
Credit to [lbrendanl](https://github.com/lbrendanl) and [Poql](http://stackoverflow.com/users/3857555/poql)



