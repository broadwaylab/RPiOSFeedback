//
//  RPCopy.swift
//  Pods
//
//  Created by Michael Orcutt on 10/6/17.
//
//

import Foundation

public class RPCopy {
    
    // MARK: – Properties
    
    enum FeedbackStep {
        
        case promptForReview
        case askForFeedback
        case displayFeedback
        case displayReviewSiteOptions
        
        func titleLabelAttributedText(feedbackType: RPSettings.FeedbackType,
                                      displayName: String,
                                      rating: Float) -> String {
            
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
                    return "Could you please rate your experience with us at \(displayName)?"
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
        
        func detailtitleLabelAttributedText(feedbackType: RPSettings.FeedbackType,
                                            name: String,
                                            rating: Float) -> String {
            
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
    
}
