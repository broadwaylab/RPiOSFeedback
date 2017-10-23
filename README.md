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

#### Present Feedback via UIViewController Extension

presentFeedback is a UIViewController extension that takes the following parameters.
* Settings
This is used for general setup such as the feedback type to present, APIKey, APISecret, etc.
* Feedback
This is the model that is constructed and sent to ReviewPush's API.
* Style
This allows you to adjust the style to your own app.
* Copy
This allows you to adjust copy however you would like.

```
presentFeedback(settings: settings, feedback: model, style: style, copy: copy)
```

Here is an example of this being implemented.

```
let settings          = RPSettings()
settings.feedbackType = .general
settings.APIKey       = APIKey
settings.APISecret    = APISecret

let feedback         = RPFeedbackModel()
feedback.reviewer    = "Michael Orcutt"
feedback.email       = "michaeltorcutt@gmail.com"
feedback.locationID  = "226699444"

let style = RPStyle()

let copy = RPCopy(feedbackType: .appStore, companyDisplayName: "ReviewPush")

presentFeedback(settings: model.settings!, feedback: model.model!, style: model.style!, copy: model.copy!)
```

### Customizing the SDK

#### Style (RPStyle Class)

This is where you change fonts, colors, corner radius, etc. 

##### Style View Properties
| Property  | Description |
| ------------- | ------------- |
| backgroundColor  | This is the background color of the full view. Typically this would be transparent. |
| containerCornerRadius  | This sets the corner radius of the container. The container is the view that contains all of the subviews  |
| containerBackgroundColor  | This sets the background color of the container. The container is the view that contains all of the subviews  |

##### Style Label Properties
| Property  | Description |
| ------------- | ------------- |
| titleLabelFont  | This sets the top label font. |
| titleLabelTextColor  | This sets the top label text color |
| descriptionLabelFont  | This secondary label font  |
| descriptionLabelTextColor  | This sets the secondary label text color  |
| sentimentLabelFont  | This sets the sentiment label font. The sentiment label is the labels below the stars displaying negative, neutral, and positive.  |
| sentimentLabelTextColor  | This sets the sentiment label text color. The sentiment label is the labels below the stars displaying negative, neutral, and positive. |

##### Style Star Properties

| Property  | Description |
| ------------- | ------------- |
| defaultColor  | Star colors when not selected. |
| selectedColor  | Star color when selected. |

##### Style Confetti Properties

| Property  | Description |
| ------------- | ------------- |
| displays  | This allows you to turn confetti on and off. |
| colors  | This is the array of colors confetti will drop as. |

##### Style Buttons Properties

| Property  | Description |
| ------------- | ------------- |
| titleLabelFont  | The font for buttons. |
| cancelButtonBackgroundColor  | This is the cancel button or dismiss button background color. |
| submitButtonBackgroundColor  | This is the submit button background color. |
| roundButtons  | This will automatically set the button corner radius to height / 2.0. |
| buttonCornerRadius  | This will explicity set button corner radius. |
| reviewSiteTitleFont  | This is the font for review sites. This only applies to general feedback |

##### RPStyle Example
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

#### Copy (RPCopy Class)

This is where you copy. 

##### TitleLabel and Description Label Properties
| Property  | Description |
| ------------- | ------------- |
| promptForReview  | This is the text that initially displays asking the user to review your site, location, etc. |
| askForFeedbackPositiveSentiment  | If the user rates 4.0 or higher, this text is displayed.  |
| askForFeedbackNegativeSentiment  | If the user rates less than 4.0, this text is displayed.  |
| displayFeedback  | If the user has accepted to give feedback, this text is displayed.  |
| displayReviewSiteOptions  | If the user agrees to review, this text is displayed.  |

```
let copy                                        = RPCopy(feedbackType: .appStore, companyDisplayName: "ReviewPush")
copy.titleLabel.promptForReview                 = "Would you like to review your experience?"
copy.titleLabel.askForFeedbackNegativeSentiment = "We're bummed you had a bad time. Can you please tell us why?"
```

### License
RPiOSFeedback is released under the MIT license. See LICENSE for details.
