//
//  Settings.swift
//  RPAppStoreFeedback
//
//  Created by Michael Orcutt on 7/13/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import Foundation

public class RPSettings {
    
    // MARK: – Enum 
    
    public struct Trigger {
        
        enum `Type` {
            
            /**
             * Display must be triggered manually
             */
            case none

            /**
             * Display will be triggered after
             * the number of times the application
             * has been opened equals the property
             * count
             */
            case applicationDidBecomeActiveCount
            
        }

        var type: Type = .none
        
        /**
         * Display will be triggered after
         * the number of times the application
         * has been opened equals the property
         * count
         */
        var applicationDidBecomeActiveCount: Int = 10
        
    }
    
    public enum FeedbackType {
        case general, appStore
    }

    // MARK: – Public Properties

    /**
     * displayName is used in copy and should
     * reflect the company that is using the SDK.
     */
    public let trigger = Trigger()
    
    /**
     * displayName is used in copy and should
     * reflect the company that is using the SDK.
     */
    public var companyDisplayName: String = "ReviewPush"
    
    /**
     * Feedback type can either be general
     * or appStore. General gets Feedback
     * for a specific location and AppStore
     * gathers feedback on the app and
     * asks the user to rate the app in
     * the App Store
     */
    public var feedbackType: FeedbackType = .appStore
    
    /**
     * appStoreIdentifier is the 
     * ID associated
     * with the app we
     * want to be reviewed.
     */
    public var appStoreIdentifier: String = "1025217655"
    
    /**
     * APIKey is the ReviewPush APIKey
     * needed to submit the API request to
     * the ReviewPush company level API.
     */
    public var APIKey: String?
    
    /**
     * APISecret is the ReviewPush APISecret
     * needed to submit the API request to
     * the ReviewPush company level API.
     */
    public var APISecret: String?
    
    /**
     * agreedToLeaveFeedback is used
     * to understand what view to show
     * next in the feedback flow.
     */
    public var agreedToLeaveFeedback: Bool = false
    
    // MARK: – Private Properties

    var applicationDidBecomeActiveCountUpdated: (() -> ())?

    // MARK: – Initialization
    
    public init() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.update),
            name: .UIApplicationDidBecomeActive,
            object: nil)
    
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: – ApplicationDidBecomeActive Helpers
    
    func shouldDisplay() -> Bool {
                
        let userDefaults = UserDefaults.standard
        
        switch self.trigger.type {
        case .applicationDidBecomeActiveCount:
            
            guard let count = userDefaults.object(forKey: "RPAppStoreFeedback.count") as? NSNumber else {
                userDefaults.set(NSNumber(value: 1), forKey: "RPAppStoreFeedback.count")
                return hasDisplayed == false
            } 
            
            return (Int(count) >= self.trigger.applicationDidBecomeActiveCount) && hasDisplayed == false
            
        default:
            return false
        }
        
    }
    
    func displayed() {
       
        let userDefaults = UserDefaults.standard

        userDefaults.set(NSNumber(value: 1), forKey: "RPAppStoreFeedback.displayed")
    
    }
    
    var hasDisplayed: Bool  {
        
        let userDefaults = UserDefaults.standard
        
        if let displayed = userDefaults.object(forKey: "RPAppStoreFeedback.displayed") as? NSNumber {
            return displayed.boolValue
        }

        return false
        
    }
    
    @objc func update() {
        
        let userDefaults = UserDefaults.standard
        
        switch self.trigger.type {
        case .applicationDidBecomeActiveCount:
            
            guard let count = userDefaults.object(forKey: "RPAppStoreFeedback.count") as? NSNumber else {
                userDefaults.set(NSNumber(value: 1), forKey: "RPAppStoreFeedback.count")
                return
            }
            
            userDefaults.set(NSNumber(value: Int(count) + 1), forKey: "RPAppStoreFeedback.count")
        default:
            break
        }
        
        applicationDidBecomeActiveCountUpdated?()
        
    }
    
}
