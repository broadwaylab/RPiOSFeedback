//
//  RPAppStoreFeedbackViewController.swift
//  RPAppStoreFeedback
//
//  Created by Michael Orcutt on 6/22/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import UIKit
import StoreKit
import Alamofire

public class RPFeedbackViewController: UIViewController {
    
    // MARK: – Step and related copy
    
    enum FeedbackStep {
        
        case promptForReview
        case askForFeedback
        case displayFeedback
        case displayReviewSiteOptions
        
        func titleLabelText(feedbackType: RPSettings.FeedbackType, companyDisplayName: String, rating: Float) -> String {
            
            switch feedbackType {
            case .appStore:
                
                switch self {
                case .promptForReview:
                    return "If you have a moment, could you please rate your experience with the ReviewPush app?"
                case .askForFeedback:
                    
                    if rating < 4.0 {
                        return "Could you tell us about your experience?"
                    } else {
                        return "Great! We’re glad you are enjoying the app."
                    }
                    
                case .displayFeedback:
                    return "Can you tell us how to improve?"
                default:
                    return String()
                }
                
            case .general:
                
                switch self {
                case .promptForReview:
                    return "Could you please rate your experience with us at \(companyDisplayName)?"
                case .askForFeedback:
                    return "Thanks!"
                case .displayFeedback:
                    return "Can you tell us how to improve?"
                case .displayReviewSiteOptions:
                    return "Please choose your preferred website below."
                default:
                    return String()
                }
                
            }
            
        }
        
        func descriptionLabelText(feedbackType: RPSettings.FeedbackType, rating: Float) -> String {
            
            switch feedbackType {
            case .appStore:
                
                switch self {
                case .askForFeedback:
                    return "Your feedback is really important."
                default:
                    return String()
                }
                
            case .general:
                
                switch self {
                case .askForFeedback:
                    
                    if rating < 4.0 {
                        return "Could you tell us about your experience?"
                    } else {
                        return "Could you do us a favor and share this on a review site?"
                    }
                    
                default:
                    return String()
                }
                
            }
            
        }
        
    }

    // MARK: – Enum
        
    enum RPAppStoreFeedbackViewControllerContainerPosition {
        case top, center, bottom
    }
        
    // MARK: – View Properties
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var poorLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var greatLabel: UILabel!
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var starButtonsStackView: UIStackView!
    @IBOutlet weak var backgroundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var reviewSitesStackView: UIStackView!
    @IBOutlet var starButtons: [UIButton]!
    @IBOutlet weak var activityIndicatorContainerView: UIView!
    var confettiView: SAConfettiView?

    var displayActivityIndicator: Bool = false {
        
        didSet {
            
            activityIndicatorView.isHidden          = !displayActivityIndicator
            activityIndicatorContainerView.isHidden = !displayActivityIndicator
            
            if displayActivityIndicator == true {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }

        }
        
    }
    // MARK: – Layout Properties

    var containerPosition: RPAppStoreFeedbackViewControllerContainerPosition = .top

    // MARK: – Data Properties
    
    var feedback: RPFeedbackModel = RPFeedbackModel()
    var style: RPStyle            = RPStyle()
    var settings: RPSettings      = RPSettings()
    var reviewSiteLinks: [String: Any]?

    // MARK: – Layout Properties

    // MARK: – View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupDisplay()
        updateStep()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let center = NotificationCenter.default
        
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(_:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(_:)),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
        
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        containerPosition = .center

        UIView.animate(withDuration: 0.35) {
            
            self.confettiView?.alpha = 1.0
            
            self.layoutContainer()
        
            self.backgroundView.backgroundColor = self.style.view.backgroundColor
            
        }

    }
    
    // MARK: – Layout
    
    func layoutContainer() {
        
        switch containerPosition {
        case .top:
            containerYConstraint.constant = -(view.bounds.height/2.0 + containerView.bounds.height/2.0)
        case .bottom:
            containerYConstraint.constant = (view.bounds.height/2.0 + containerView.bounds.height/2.0)
        case .center:
            containerYConstraint.constant = 0.0
        }
        
        self.view.layoutIfNeeded()

    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        layoutContainer()
        
    }
    
    // MARK: – Status Bar
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: – Setup and Apply Style
    
    func setupDisplay() {
        
        setupStars()
        setupConfettiView()
        setupSentimentLabels()
        setupButtons()
        setupTextView()
        setupActivityIndicatorView()
        setupContainer()
    }
    
    func setupContainer() {
        
        containerPosition = .top
        
        containerView.layer.cornerRadius = style.view.containerCornerRadius

    }
    
    func setupActivityIndicatorView() {
        activityIndicatorContainerView.layer.cornerRadius = style.view.containerCornerRadius
    }
    
    func setupStars() {

        let starImage = UIImage.starImage(forClass: RPFeedbackViewController.self)
        
        for starButton in starButtons {
            starButton.setImage(starImage, for: .normal)
            starButton.tintColor = style.stars.defaultColor
        }

    }
    
    func setupConfettiView() {
        
        if style.confetti.displays == false {
            return
        }
        
        confettiView         = SAConfettiView(frame: self.view.bounds)
        confettiView?.colors = style.confetti.colors
        confettiView?.type   = .star
        confettiView?.alpha  = 0.0
        
        confettiView?.startConfetti()
        
        backgroundView.insertSubview(confettiView!, belowSubview: containerView)
        
    }

    func setupSentimentLabels() {
        
        poorLabel.text    = "Poor"
        averageLabel.text = "Average"
        greatLabel.text   = "Great"
        helperLabel.text  = "Tap the number of stars 1-5, to give us feedback."

        [poorLabel, averageLabel, greatLabel].forEach({ label in
            label?.font      = style.labels.sentimentLabelFont
            label?.textColor = style.labels.sentimentLabelTextColor
        })

    }
    
    func setupButtons() {
        
        if style.buttons.roundButtons == true {
            
            yesButton.layer.cornerRadius      = 25.0
            noThanksButton.layer.cornerRadius = 25.0
            
        } else {
            
            yesButton.layer.cornerRadius      = style.buttons.buttonCornerRadius
            noThanksButton.layer.cornerRadius = style.buttons.buttonCornerRadius
            
        }
        
        yesButton.backgroundColor      = style.buttons.submitButtonBackgroundColor
        noThanksButton.backgroundColor = style.buttons.cancelButtonBackgroundColor
        
        yesButton.titleLabel?.font      = style.buttons.titleLabelFont
        noThanksButton.titleLabel?.font = style.buttons.titleLabelFont

        yesButton.layoutIfNeeded()
        noThanksButton.layoutIfNeeded()
        buttonStackView.layoutIfNeeded()
        view.layoutIfNeeded()
        
        if style.buttons.roundButtons == true {

            yesButton.layer.cornerRadius      = 25.0
            noThanksButton.layer.cornerRadius = 25.0

        } else {
            
            yesButton.layer.cornerRadius      = style.buttons.buttonCornerRadius
            noThanksButton.layer.cornerRadius = style.buttons.buttonCornerRadius

        }
    }
    
    func setupTextView() {
        
        textView.layer.cornerRadius = 4.0
        textView.textContainerInset = UIEdgeInsetsMake(15.0, 12.0, 15.0, 12.0)
        textView.typingAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor(white: 0.0, alpha: 0.7)]

    }
    
    // MARK: – Step
    
    func updateStep() {
        
        let step = self.step()
        
        updateLabels(step: step)
        displayViews(step: step)
        
    }
    
    func updateLabels(step: FeedbackStep) {

        titleLabel.text = step.titleLabelText(feedbackType: settings.feedbackType, companyDisplayName: settings.companyDisplayName, rating: feedback.rating ?? 0)
        
        titleLabel.font      = style.labels.titleLabelFont
        titleLabel.textColor = style.labels.titleLabelTextColor

        descriptionLabel.text  = step.descriptionLabelText(feedbackType: settings.feedbackType, rating: feedback.rating ?? 0)

        descriptionLabel.font      = style.labels.descriptionLabelFont
        descriptionLabel.textColor = style.labels.descriptionLabelTextColor

    }
    
    func displayViews(step: FeedbackStep) {

        switch step {
        case .promptForReview:

            var layoutMargins    = starButtonsStackView.layoutMargins
            layoutMargins.bottom = 5.0
            
            self.starButtonsStackView.layoutMargins = layoutMargins

            titleLabel.isHidden           = false
            buttonStackView.isHidden      = true
            starButtonsStackView.isHidden = false
            poorLabel.isHidden            = true
            averageLabel.isHidden         = true
            greatLabel.isHidden           = true
            helperLabel.isHidden          = true
            descriptionLabel.isHidden     = true
            reviewSitesStackView.isHidden = true

        case .askForFeedback:
            
            buttonStackView.isHidden      = false
            starButtonsStackView.isHidden = false
            poorLabel.isHidden            = true
            averageLabel.isHidden         = true
            greatLabel.isHidden           = true
            helperLabel.isHidden          = true
            descriptionLabel.isHidden     = false
            titleLabel.isHidden           = false

        case .displayFeedback:
            
            buttonStackView.isHidden      = false
            starButtonsStackView.isHidden = true
            poorLabel.isHidden            = true
            averageLabel.isHidden         = true
            greatLabel.isHidden           = true
            helperLabel.isHidden          = true
            descriptionLabel.isHidden     = true
            titleLabel.isHidden           = false
            textView.isHidden             = false

            noThanksButton.setTitle("Cancel", for: .normal)
            yesButton.setTitle("Submit", for: .normal)

        case .displayReviewSiteOptions:
            
            buttonStackView.isHidden      = false
            starButtonsStackView.isHidden = true
            poorLabel.isHidden            = true
            averageLabel.isHidden         = true
            greatLabel.isHidden           = true
            helperLabel.isHidden          = true
            yesButton.isHidden            = true
            descriptionLabel.isHidden     = true
            titleLabel.isHidden           = false
            textView.isHidden             = true
            reviewSitesStackView.isHidden = false

        default: break
        }

    }
    
    func step() -> FeedbackStep {
        
        switch settings.feedbackType {
        case RPSettings.FeedbackType.general:
            
            guard let rating = feedback.rating else {
                return .promptForReview
            }
            
            if !settings.agreedToLeaveFeedback {
                return .askForFeedback
            } else if settings.agreedToLeaveFeedback && rating >= 4.0 {
                return .displayReviewSiteOptions
            } else {
                return .displayFeedback
            }
            
        case RPSettings.FeedbackType.appStore:
            
            guard let rating = feedback.rating else {
                return .promptForReview
            }

            if !settings.agreedToLeaveFeedback {
                return .askForFeedback
            } else {
                return .displayFeedback
            }
            
            break
            
        }
        
    }
    
    // MARK: – Button Methods
    
    @IBAction func starTap(_ sender: UIButton) {
        
        let rating = (sender.tag - 1000)
        
        updateRating(Float(rating))
        
    }
    
    // MARK: – Rating
    
    func updateRating(_ rating: Float) {
        
        feedback.rating = rating
        
        for (index, starButton) in starButtons.enumerated() {
            
            let tag = (starButton.tag - 1000)

            if Float(tag) > rating {
                starButton.tintColor = style.stars.defaultColor
            } else {
                starButton.tintColor = style.stars.selectedColor
            }
            
        }
        
        updateStep()
        
    }

    // MARK: – Button actions
    
    @IBAction func yesTapped(_ sender: Any) {
        
        let previouslyAgreedToLeaveFeedback = settings.agreedToLeaveFeedback
        
        settings.agreedToLeaveFeedback = true
        
        feedback.text = textView.text
        
        let step = self.step()
        
        if step == .displayReviewSiteOptions || (step == .displayFeedback && previouslyAgreedToLeaveFeedback == true) {
            submit(cancelled: false)
        }
        
        updateStep()
    
    }
    
    @IBAction func noThanksTapped(_ sender: Any) {
        
        updateStep()
        
        switch step() {
        case .displayReviewSiteOptions:
            dismiss(displayReview: false)
        default:
            submit(cancelled: true)
        }
        
    }
    
    // MARK: – Networking
    
    func submit(cancelled: Bool) {
        
        displayActivityIndicator = true
        
        feedback.text = textView.text
        
        Alamofire.request(RPFeedbackRouter.feedback(feedback, settings)).responseJSON { (response: DataResponse<Any>) in
            
            self.handleResponse(response, cancelled: cancelled)
            
            self.descriptionLabel.isHidden = true
            
        }

    }
    
    func handleResponse(_ response: DataResponse<Any>, cancelled: Bool) {
        
        switch response.result {
        case .success:
            
            if settings.feedbackType == .appStore || cancelled == true || self.step() == FeedbackStep.displayFeedback {
                self.dismiss(displayReview: (settings.feedbackType == .appStore))
            } else if settings.feedbackType == .general && settings.agreedToLeaveFeedback == true {
                self.updateReviewSites(JSON: response.result.value)
            }
            
        case .failure(_):
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            let controller = UIAlertController(title: "Error!", message: "There was an error. Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            
            controller.addAction(action)
            
            self.present(controller, animated: true, completion: nil)
            
        }

    }
    
    func updateReviewSites(JSON: Any?) {
        
        if let JSON = JSON as? [String:Any],
        let reviewSiteLinks = JSON["review_site_links"] as? [String:Any] {
            
            reviewSiteLinks.forEach({ (object : (key: String, value: Any)) in
                
                let button = UIButton(type: .system)
                
                button.setTitle(object.key, for: .normal)
                button.setTitleColor(UIColor.gray, for: .normal)
                button.titleLabel?.font = style.buttons.reviewSiteTitleFont
                
                button.addTarget(self, action: #selector(RPFeedbackViewController.handleLink(_:)), for: .touchUpInside)
                
                reviewSitesStackView.addArrangedSubview(button)
                
            })
            
            self.reviewSiteLinks = reviewSiteLinks
            
            self.buttonStackView.isHidden = true
            
        }
        
        self.displayActivityIndicator = false
        
    }
    
    func handleLink(_ sender: UIButton) {
        
        guard
            let reviewSiteLinks = self.reviewSiteLinks,
            let reviewSite = reviewSiteLinks[sender.title(for: .normal)!] as? [String: Any],
            let link = reviewSite["url"] as? String else {
            return
        }
        
        guard let url = URL(string: link) else {
            return
        }
        
        self.dismiss(displayReview: false)
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    // MARK: – Keyboard
    
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            backgroundViewHeightConstraint.constant -= keyboardSize.height
        }

    }

    func keyboardWillHide(_ notification: Notification) {
        
        backgroundViewHeightConstraint.constant = 0.0

    }
    
    // MARK: – Helpers
    
    static public func instance() -> RPFeedbackViewController {
        
        let frameworkBundle = Bundle(for: self)
        
        let bundleURL = frameworkBundle.url(forResource: "RPiOSFeedback", withExtension: "bundle")
        
        let bundle = Bundle(url: bundleURL!)


        let fileManager = FileManager.default
        
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: (bundle?.resourceURL!)!, includingPropertiesForKeys:[], options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            print("docsArray", urls)
        } catch {
            print(error)
        }

        let storyboard = UIStoryboard(name: "Main", bundle: bundle)

        let viewController =
            storyboard.instantiateViewController(withIdentifier: "RPFeedbackViewController") as!
        RPFeedbackViewController

        return viewController
        
    }
    
    // MARK: – Button methods
    
    @IBAction func handleClose(_ sender: Any) {
        dismiss(displayReview: false)
    }
    
    // MARK: – Dismiss Helpers
    
    func dismiss(displayReview: Bool) {
        
        containerPosition = .bottom
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.confettiView?.alpha = 0.0
            self.dismissButton.alpha = 0.0
            
            self.backgroundView.backgroundColor = UIColor.clear
            
            self.layoutContainer()

        }) { (_) in
            
            self.dismiss(animated: false, completion: {
                
                if displayReview == false {
                    return
                }
                
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                } else {
                    
                    let appID = self.settings.appStoreIdentifier
                    
                    let URLString = "itms-apps://itunes.apple.com/app/id\(appID)"
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string: URLString)!, options: [:], completionHandler: nil)
                    } else {

                    }
                    
                }
                
            })
            
        }

    }
    
}
