//
//  Model.swift
//  RPFeedbackExample
//
//  Created by Michael Orcutt on 10/6/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import Foundation
import RPAppStoreFeedback

class Model {
    
    var title: String?
    var type: RPSettings.FeedbackType = .general
    
    convenience init(title: String, type: RPSettings.FeedbackType) {
        self.init()
        
        self.title = title
        self.type  = type
    }
    
}
