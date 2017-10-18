//
//  ViewController.swift
//  RPFeedbackExample
//
//  Created by Michael Orcutt on 10/6/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import UIKit
import RPiOSFeedback
import Alamofire

class ViewController: UIViewController {
    
    struct Colors {
        let blue  = UIColor(red: 52.0/255.0, green: 67.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        let green = UIColor(red: 69.0/255.0, green: 203.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        let red   = UIColor(red: 234.0/255.0, green: 92.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    }
    
    var models: [Model] = []
    let APIKey    = "<Insert APIKEY Here>"
    let APISecret = "<Insert APISecret Here>"
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var loading: Bool = false {
        
        didSet {
            
            let alpha: CGFloat = loading ? 1.0 : 0.0
            
            if(loading) {
                activityIndicatorView.startAnimating()
            }
            
            UIView.animate(withDuration: 0.25) { 
                self.activityIndicatorView.alpha = alpha
            }
            
        }
        
    }
    
    // MARK: – Properties
    
    let colors = Colors()
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: – View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "RPiOSFeedback Examples"
        
        navigationController?.navigationBar.barTintColor        = UIColor.white
        navigationController?.navigationBar.isTranslucent       = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colors.blue]
        
        setupModels()
        
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    // MARK: – Setup models
    
    func appStoreModel() -> Model {
    
        let settings          = RPSettings()
        settings.feedbackType = .appStore
        settings.APIKey       = APIKey
        settings.APISecret    = APISecret
        
        let feedback         = RPFeedbackModel()
        feedback.reviewer    = "Michael Orcutt"
        feedback.email       = "michaeltorcutt@gmail.com"
        feedback.locationID  = "22669"
        
        let style                                 = RPStyle()
        style.view.backgroundColor                = UIColor.black.withAlphaComponent(0.60)
        style.buttons.cancelButtonBackgroundColor = colors.red
        style.buttons.submitButtonBackgroundColor = colors.green
        
        let copy = RPCopy(feedbackType: .appStore, companyDisplayName: "ReviewPush")

        return Model(title: "Present Feedback with Confetti", settings: settings, model: feedback, style: style, copy: copy)
        
    }
    
    func generalModelWithCustomStyle() -> Model {
        
        let settings          = RPSettings()
        settings.feedbackType = .general
        settings.APIKey       = APIKey
        settings.APISecret    = APISecret
        
        let feedback         = RPFeedbackModel()
        feedback.reviewer    = "Michael Orcutt"
        feedback.email       = "michaeltorcutt@gmail.com"
        feedback.locationID  = "22669"
        
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
        
        style.buttons.roundButtons = false
        
        let copy = RPCopy(feedbackType: .appStore, companyDisplayName: "ReviewPush")
        
        return Model(title: "Present Feedback", settings: settings, model: feedback, style: style, copy: copy)
        
    }
    
    func generalModelWithCustomCopy() -> Model {
        
        let settings          = RPSettings()
        settings.feedbackType = .general
        settings.APIKey       = APIKey
        settings.APISecret    = APISecret
        
        let feedback         = RPFeedbackModel()
        feedback.reviewer    = "Michael Orcutt"
        feedback.email       = "michaeltorcutt@gmail.com"
        feedback.locationID  = "22669"
        
        let style                  = RPStyle()
        style.view.backgroundColor = colors.blue.withAlphaComponent(0.60)

        let copy                                        = RPCopy(feedbackType: .appStore, companyDisplayName: "ReviewPush")
        copy.titleLabel.promptForReview                 = "Would you like to review your experience?"
        copy.titleLabel.askForFeedbackNegativeSentiment = "We're bummed you had a bad time. Can you please tell us why?"

        return Model(title: "Present Feedback with Custom Copy", settings: settings, model: feedback, style: style, copy: copy)
        
    }
    
    func generalModelWithoutLocation() -> Model {
        
        let settings          = RPSettings()
        settings.feedbackType = .general
        settings.APIKey       = APIKey
        settings.APISecret    = APISecret
        
        let feedback         = RPFeedbackModel()
        feedback.reviewer    = "Michael Orcutt"
        feedback.email       = "michaeltorcutt@gmail.com"
        
        let style                  = RPStyle()
        style.view.backgroundColor = colors.blue.withAlphaComponent(0.60)
        
        let copy = RPCopy(feedbackType: .general, companyDisplayName: "ReviewPush")
        
        return Model(title: "Present Feedback Lookup Locations", settings: settings, model: feedback, style: style, copy: copy)
        
    }

    
    func setupModels() {
        
        models.append(appStoreModel())
        models.append(generalModelWithCustomStyle())
        models.append(generalModelWithCustomCopy())
        models.append(generalModelWithoutLocation())


    }
    
    // MARK: – Display App Store Feedback
    
    func displayFeedbackForModel(_ model: Model) {
        
        // We know an ID is available here
        if let feedbackModel = model.model, let _ = feedbackModel.locationID {
            
            presentFeedback(settings: model.settings!, feedback: model.model!, style: model.style!, copy: model.copy!)
            
            return
            
        }
        
        loading = true
        
        // Example looking up locations. You can lookup by CLLocation coordinates.
        Alamofire.request(RPFeedbackRouter.locations(nil, model.settings!)).responseJSON { dataResponse in
            
            guard let JSON = dataResponse.result.value as? [String: Any], let data = JSON["data"] as? [[String: Any]] else {
                return
            }
            
            let firstLocation = data.first
            
            if let firstLocationIdentifier = firstLocation?["id"] as? String {
                
                model.model!.locationID = firstLocationIdentifier
                
                self.presentFeedback(settings: model.settings!, feedback: model.model!, style: model.style!, copy: model.copy!)

            }
            
            self.loading = false
            
        }


    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: – UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "CellIdentifier")
        
        let model = models[indexPath.row]
        
        if let title = model.title {
            tableViewCell.textLabel?.text = title
        }
        
        return tableViewCell
        
    }
    
    // MARK: – UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = models[indexPath.row]

        displayFeedbackForModel(model)
        
    }

    
}
