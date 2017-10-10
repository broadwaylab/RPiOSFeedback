//
//  ViewController.swift
//  RPFeedbackExample
//
//  Created by Michael Orcutt on 10/6/17.
//  Copyright © 2017 Michael Orcutt. All rights reserved.
//

import UIKit
import RPiOSFeedback

class ViewController: UIViewController {
    
    struct Colors {
        let blue  = UIColor(red: 52.0/255.0, green: 67.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        let green = UIColor(red: 69.0/255.0, green: 203.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        let red   = UIColor(red: 234.0/255.0, green: 92.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    }
    
    let models = [
        Model(title: "Present General Feedback", type: .general),
        Model(title: "Present App Store Feedback", type: .appStore)
    ]
    
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
        
        tableView.tableFooterView = UIView()

        tableView.reloadData()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    // MARK: – Status bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: – Display App Store Feedback
    
    func displayFeedbackForModel(_ model: Model) {
        
        let settings          = RPSettings()
        settings.feedbackType = model.type
        settings.APIKey       = "499e6316d767057f2f50ec145f15fb6d"
        settings.APISecret    = "4c78d668dbebf347164749ed3794fb0a"

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
        
        presentFeedback(settings: settings, feedback: feedback, style: style)

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
