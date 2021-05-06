//
//  RecordViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 06/05/21.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var recordTableView: UITableView!
    
    var negativeEmotions: [NegativeEmotion]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let buttonAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-Regular", size: 20)!
        ]
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(buttonAttr, for: .normal)
        
        recordTableView.dataSource = self
        recordTableView.delegate = self
        recordTableView.register(UINib(nibName: "ActionRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionRecordCell")
    }
    
}

extension RecordViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return negativeEmotions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionRecordCell", for: indexPath) as! ActionRecordTableViewCell
        
        let negativeEmotion = negativeEmotions[indexPath.section]
        var actions = negativeEmotion.actions?.allObjects as! [Action]
        actions.sort {
            $0.totalSolved > $1.totalSolved
        }
        
        var topActions: [Action] = []
        
        if actions.count > 2 {
            topActions = Array(actions.prefix(3))
        } else {
            topActions = Array(actions.prefix(actions.count))
        }
        
        cell.negativeEmotionNameLabel.text = negativeEmotion.name
        let stringMedal = ["🥇", "🥈", "🥉"]
        
        
        for (index, topAction) in topActions.enumerated() {
            if topAction.totalSolved > 0 {
                cell.actionRecordLabel.text! += "\(stringMedal[index]) \(topAction.title!)\n"
            }
            
        }
        
        if cell.actionRecordLabel.text == "" {
            cell.actionRecordLabel.text! += "No record yet"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
}

extension RecordViewController: UITableViewDelegate {
    
}
