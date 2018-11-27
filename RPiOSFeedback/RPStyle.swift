//
//  RPAppStoreFeedbackStyle.swift
//  Pods
//
//  Created by Michael Orcutt on 10/6/17.
//
//

import UIKit

@available(iOS 8.2, *)
public class RPStyle {
    
    // MARK: – Properties
    
    public var view: View         = View()
    public var labels: Labels     = Labels()
    public var confetti: Confetti = Confetti()
    public var stars: Stars       = Stars()
    public var buttons: Buttons   = Buttons()

    // MARK: – Init
    
    public init() {
        
    }
    
    // MARK: – Structs

    public struct View {
        
        public var backgroundColor: UIColor          = UIColor.black.withAlphaComponent(0.25)
        public var containerCornerRadius: CGFloat    = 5.0
        public var containerBackgroundColor: UIColor = UIColor.white

    }
    
    public struct Labels {
    
        public var titleLabelFont: UIFont             = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.semibold)
        public var titleLabelTextColor: UIColor       = UIColor.darkGray
        public var descriptionLabelFont: UIFont       = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        public var descriptionLabelTextColor: UIColor = UIColor.lightGray
        public var sentimentLabelFont: UIFont         = UIFont.systemFont(ofSize: 11.0, weight: UIFont.Weight.light)
        public var sentimentLabelTextColor: UIColor   = UIColor.lightGray

    }
    
    public struct Stars {

        public var defaultColor: UIColor  = UIColor(red: 173.0/255.0, green: 173.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        public var selectedColor: UIColor = UIColor(red: 27.0/255.0, green: 143.0/255.0, blue: 190.0/255.0, alpha: 1.0)

    }
    
    public struct Confetti {
        
        public var displays: Bool = true
        
        public var colors = [
            UIColor(red: 173.0/255.0, green: 173.0/255.0, blue: 173.0/255.0, alpha: 1.0),
            UIColor(red: 23.0/255.0, green: 210.0/255.0, blue: 232.0/255.0, alpha: 1.0),
            UIColor(red: 0.0/255.0, green: 194.0/255.0, blue: 129.0/255.0, alpha: 1.0),
            UIColor(red: 238.0/255.0, green: 104.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        ]
        
    }
    
    public struct Buttons {
        
        public var titleLabelFont: UIFont                    = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.semibold)
        public var cancelButtonBackgroundColor: UIColor      = UIColor(red: 173.0/255.0, green: 173.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        public var submitButtonBackgroundColor: UIColor      = UIColor(red: 27.0/255.0, green: 143.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        public var roundButtons: Bool                        = true
        public var buttonCornerRadius: CGFloat               = 0.0
        public var reviewSiteTitleFont: UIFont               = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        public var reviewSiteCancelButtonFont: UIFont        = UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.semibold)
        public var reviewSiteCancelButtonTitleColor: UIColor = UIColor(white: 0.0, alpha: 0.50)

    }
    
}
