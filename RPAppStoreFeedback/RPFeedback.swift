//
//  RPAppStoreFeedback.swift
//  RPAppStoreFeedback
//
//  Created by Michael Orcutt on 7/13/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import Foundation

public class RPFeedback {
    
    // MARK: – Properties

    private var feedback: RPFeedbackModel?
    private var settings: RPSettings = RPSettings()
    private var style: RPStyle       = RPStyle()
    private var presentingViewController: UIViewController?
    public static let shared = RPFeedback()

    // MARK: – Initialization
    
    public func setup(settings: RPSettings?,
                      feedback: RPFeedbackModel?,
                      style: RPStyle?,
                      presentingViewController: UIViewController) {
        
        if let settings = settings {
            self.settings = settings
        }
        
        if let feedback = feedback {
            self.feedback = feedback
        }
        
        if let style = style {
            self.style = style
        }
        
        self.presentingViewController = presentingViewController
        
        self.settings.applicationDidBecomeActiveCountUpdated = {
            self.display(force: false)
        }
        
        self.display(force: false)
        
    }
    
    // MARK: – Display
    
    private func display(force: Bool) {
        
        let viewController                    = RPFeedbackViewController.instance()
        viewController.modalPresentationStyle = .overCurrentContext
        
        if let feedback = self.feedback {
            viewController.feedback = feedback
        }
        
        viewController.style    = style
        viewController.settings = settings
        
        switch settings.trigger.type {
        case .applicationDidBecomeActiveCount:
            
            if self.settings.shouldDisplay() {
                self.presentingViewController?.present(viewController, animated: false, completion: {
                    self.settings.displayed()
                })
            }

        default:
            
            if force == true {
                self.presentingViewController?.present(viewController, animated: false, completion: {
                    self.settings.displayed()
                })
            }
            
        }
        
    }
    
}

extension UIViewController {
    
    public func presentFeedback(settings: RPSettings?, feedback: RPFeedbackModel?, style: RPStyle?) {
        
        let viewController                    = RPFeedbackViewController.instance()
        viewController.modalPresentationStyle = .overCurrentContext
        
        if let feedback = feedback {
            viewController.feedback = feedback
        }
        
        if let style = style {
            viewController.style = style
        }
        
        if let settings = settings {
            viewController.settings = settings
        }

        present(viewController, animated: false, completion: nil)
        
    }
    
}

