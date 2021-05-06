//
//  DetailActiveNegativeEmotionViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 05/05/21.
//

import UIKit

class DetailActiveNegativeEmotionViewController: UIViewController {
    @IBOutlet weak var negativeEmotionImage: UIImageView!
    @IBOutlet weak var negativeEmotionNameLabel: UILabel!
    @IBOutlet weak var actionTable: UITableView!
    @IBOutlet weak var secondBackground: UIView!
    @IBOutlet weak var solvedButton: UIButton!
    
    var negativeEmotion: NegativeEmotion!
    var actions: [Action] = []
    var sortedActions: [Action] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.detailActiveNegativeEmotionVC = self
        actions = negativeEmotion.actions?.allObjects as! [Action]
        
        for action in actions {
            if(action.isDone) {
                sortedActions.append(action)
            } else {
                sortedActions.insert(action, at: 0)
            }
        }
            
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let buttonAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-Regular", size: 20)!
        ]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Info", style: .plain, target: self, action: #selector(infoButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(buttonAttr, for: .normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(buttonAttr, for: .normal)
        
        DispatchQueue.main.async {
            self.negativeEmotionNameLabel.text = self.negativeEmotion.name
            self.negativeEmotionImage.image = UIImage(named: self.negativeEmotion.image ?? "anxious")
        }
        
        solvedButton.layer.cornerRadius = solvedButton.frame.height / 2
        secondBackground.layer.cornerRadius = 20
        secondBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        actionTable.dataSource = self
        actionTable.delegate = self
        actionTable.register(UINib(nibName: "ActionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionCell")
    }
    
    @IBAction func addNewActionButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add New Action", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Action Title"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            guard let titleTextFieldText = alertController.textFields![0].text else {
                fatalError()
            }
            let newAction = DataManager.shared.addAction(title: titleTextFieldText, negativeEmotion: self.negativeEmotion)
            
            self.sortedActions.insert(newAction, at: 0)
            
            self.actionTable.beginUpdates()
            self.actionTable.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            self.actionTable.endUpdates()
        
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func solvedButtonPressed(_ sender: UIButton) {
        guard let congratulationVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CongratulationViewControllerIdentifier") as CongratulationViewController? else {
            return
        }
        
        congratulationVC.negativeEmotion = negativeEmotion
        congratulationVC.actions = sortedActions
        
        navigationController?.pushViewController(congratulationVC, animated: true)
    }
    
    @objc func infoButtonPressed(_ sender: UIBarButtonItem) {
        let negativeEmotionInfoPopupViewController = NegativeEmotionInfoPopupViewController(nibName: "NegativeEmotionInfoPopupView", bundle: nil)
        negativeEmotionInfoPopupViewController.modalPresentationStyle = .overCurrentContext
        negativeEmotionInfoPopupViewController.negativeEmotion = negativeEmotion
        negativeEmotionInfoPopupViewController.isConfirmation = false
        
        self.present(negativeEmotionInfoPopupViewController, animated: false, completion: nil)
        negativeEmotionInfoPopupViewController.confirmationButton.setTitle("Got it", for: .normal)
    }

}

extension DetailActiveNegativeEmotionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedActions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath) as! ActionTableViewCell
        
        let action = sortedActions[indexPath.row]
        cell.action = action
        
        return cell
    }
}

extension DetailActiveNegativeEmotionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let action = sortedActions[indexPath.row]
            DataManager.shared.deleteAction(action: action)
            sortedActions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
