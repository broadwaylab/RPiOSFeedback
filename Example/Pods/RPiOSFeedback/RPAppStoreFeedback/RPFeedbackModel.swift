//
//  Feedback.swift
//  RPAppStoreFeedback
//
//  Created by Michael Orcutt on 7/9/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import Foundation

public class RPFeedbackModel {
    
    // MARK: – Properties
    
    /**
     * Text is the associated text
     * sent with feedback. This 
     * is not always passed along
     * to the servers.
     */
    public var text: String?
    
    /**
     * Reviewer is the name
     * of the user. This can
     * be first, last, or full.
     */
    public var reviewer: String?
    
    /**
     * Email is the associated
     * users email address.
     */
    public var email: String?
    
    /**
     * LocationID is the location
     * associated with the feedback.
     * This ID pertains to ReviewPush's
     * associated locationID.
     */
    public var locationID: String?
    
    /** 
     * Rating is a 1-5 star rating
     */
    public var rating: Float?
    
    public var meta: Meta = Meta()
    
    public init() {
    }
        
}
