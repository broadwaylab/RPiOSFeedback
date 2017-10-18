//
//  Model.swift
//  RPFeedbackExample
//
//  Created by Michael Orcutt on 10/6/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import Foundation
import RPiOSFeedback

class Model {
    
    var title: String?
    var settings: RPSettings?
    var model: RPFeedbackModel?
    var style: RPStyle?
    var copy: RPCopy?
    
    convenience init(title: String, settings: RPSettings, model: RPFeedbackModel, style: RPStyle, copy: RPCopy) {
        self.init()
        
        self.title    = title
        self.settings = settings
        self.model    = model
        self.style    = style
        self.copy     = copy

    }
    
}
