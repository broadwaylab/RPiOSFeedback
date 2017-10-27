//
//  RPCopy.swift
//  RPiOSFeedback
//
//  Created by Michael Orcutt on 10/13/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import UIKit

public class RPCopy {
    
    // MARK: – Properties
    
    public struct TitleLabel {

        public var promptForReview: String                 = ""
        public var askForFeedbackPositiveSentiment: String = ""
        public var askForFeedbackNegativeSentiment: String = ""
        public var displayFeedback: String                 = ""
        public var displayReviewSiteOptions: String        = ""
        
    }
    
    public struct DescriptionLabel {
        
        public var promptForReview: String                 = ""
        public var askForFeedbackPositiveSentiment: String = ""
        public var askForFeedbackNegativeSentiment: String = ""
        public var displayFeedback: String                 = ""
        public var displayReviewSiteOptions: String        = ""
        
    }

    public var titleLabel: TitleLabel             = TitleLabel()
    public var descriptionLabel: DescriptionLabel = DescriptionLabel()

    // MARK: – Initialization

    public init() {
        
    }
    
    public convenience init(feedbackType: RPSettings.FeedbackType, companyDisplayName: String) {
        self.init()
        
        setupTitleLabelText(feedbackType: feedbackType, companyDisplayName: companyDisplayName)
        setupDetailTitleLabelText(feedbackType: feedbackType)
        
    }
    
    func setupTitleLabelText(feedbackType: RPSettings.FeedbackType, companyDisplayName: String) {
        
        switch feedbackType {
        case .appStore:
            
            titleLabel.promptForReview = "If you have a moment, could you please rate your experience with the \(companyDisplayName) app?"
            
            titleLabel.askForFeedbackNegativeSentiment  = "Thanks for the feedback! Can you also do us a big favor and submit this rating to the app store?"
            
            titleLabel.askForFeedbackPositiveSentiment  = "Thanks for the feedback! Can you also do us a big favor and submit this rating to the app store?"

            titleLabel.displayFeedback = "Can you tell us how to improve?"
            
        case .general:

            titleLabel.promptForReview = "Could you please rate your experience with us at \(companyDisplayName)?"

            titleLabel.askForFeedbackPositiveSentiment = "Thanks!"

            titleLabel.askForFeedbackNegativeSentiment = "Thanks!"

            titleLabel.displayFeedback = "Can you tell us how to improve?"

            titleLabel.displayReviewSiteOptions = "Please choose your preferred website below."

        }

    }
    
    func setupDetailTitleLabelText(feedbackType: RPSettings.FeedbackType) {
        
        switch feedbackType {
        case .appStore:
           
            descriptionLabel.askForFeedbackNegativeSentiment = "Your feedback is really important."
            descriptionLabel.askForFeedbackPositiveSentiment = "Your feedback is really important."
            
        case .general:
            
            descriptionLabel.askForFeedbackNegativeSentiment = "Could you tell us about your experience?"
            descriptionLabel.askForFeedbackPositiveSentiment = "Could you do us a favor and share this on a review site?"

        }

    }
    
    // MARK: – Helpers
    
    func titleLabelText(feedbackStep: RPFeedbackViewController.FeedbackStep, rating: Float) -> String {
        
        switch feedbackStep {
        case .askForFeedback:
            
            if rating >= 4.0 {
                return titleLabel.askForFeedbackPositiveSentiment
            } else {
                return titleLabel.askForFeedbackNegativeSentiment
            }
    
        case .displayFeedback:
            
            return titleLabel.displayFeedback
            
        case .displayReviewSiteOptions:

            return titleLabel.displayReviewSiteOptions

        case .promptForReview:
            
            return titleLabel.promptForReview

        }
        
    }

    func descriptionLabelText(feedbackStep: RPFeedbackViewController.FeedbackStep, rating: Float) -> String {
        
        switch feedbackStep {
        case .askForFeedback:
            
            if rating >= 4.0 {
                return descriptionLabel.askForFeedbackPositiveSentiment
            } else {
                return descriptionLabel.askForFeedbackNegativeSentiment
            }
            
        case .displayFeedback:
            
            return descriptionLabel.displayFeedback
            
        case .displayReviewSiteOptions:
            
            return descriptionLabel.displayReviewSiteOptions
            
        case .promptForReview:
            
            return descriptionLabel.promptForReview
            
        }
        
    }
    
}
