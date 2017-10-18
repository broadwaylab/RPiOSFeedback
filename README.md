## RPiOSFeedback 
RPiOSFeedback is an iOS framework for [ReviewPush](https://www.reviewpush.com). You can use this to request feedback for your business or iOS application.

#### Getting Started
RPiOSFeedback can be installed by adding the following to your Podfile:

`pod 'RPiOSFeedback', :git => 'https://github.com/mtorcutt/RPiOSFeedback.git'`

##### Minimum iOS Requirements

| RPFeedback Version | Minimum iOS Version  |
| :------------------: |:------------------:|
| 0.0.x                | iOS 10             |

##### Required Credentials
To use this SDK you will need both an API key and secret. These credentials can be found on your [ReviewPush Dashboard](http://dashboard.reviewpush.com/) under Settings -> ReviewPush API.

Note: This information is only available to accounts with admin rights.

#### Example App
In order to use the example app successfully, you will need to replace the APIKey and APISecret credentials in the ViewController class.

The location of these constants can be found [here.](https://github.com/mtorcutt/RPiOSFeedback/blob/dev/Example/RPFeedbackExample/ViewController.swift#L22)

The app has several style and data variations.

#### Types of Feedback to Present

* App Store Feedback
Present the user with the option to rate your app, gather feedback, and then rate the app on the App Store.

* General Feedback
Present the user with the option to rate a business location, gather feedback, and rate the app on various review sites.

#### Customizing the SDK

### Style (RPStyle Class)

```
        let style                                 = RPStyle()
        
        style.view.backgroundColor                = colors.blue.withAlphaComponent(0.60)
        style.confetti.displays                   = false
        style.stars.defaultColor                  = UIColor.lightGray.withAlphaComponent(0.75)
        style.stars.selectedColor                 = colors.green
        style.labels.titleLabelFont               = UIFont.boldSystemFont(ofSize: 20.0)
        style.labels.descriptionLabelFont         = UIFont.boldSystemFont(ofSize: 14.0)
        style.buttons.buttonCornerRadius          = 3.0
        style.buttons.cancelButtonBackgroundColor = colors.red
        style.buttons.submitButtonBackgroundColor = colors.green
        
        
```



### License
RPiOSFeedback is released under the MIT license. See LICENSE for details.
