//
//  ActionTableViewCell.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 05/05/21.
//

import UIKit

class ActionTableViewCell: UITableViewCell {

    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var actionTitleLabel: UILabel!
    
    var action: Action!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        DispatchQueue.main.async {
            self.actionTitleLabel.text = self.action.title
            self.setCheckmarkButtonImage()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func checkmarkButtonPressed(_ sender: UIButton) {
        
        
        guard let detailActiveNegativeEmotionVC = DataManager.shared.detailActiveNegativeEmotionVC else {return}
        guard let actionTable = detailActiveNegativeEmotionVC.actionTable else { return }
        
        guard let cell = sender.superview?.superview as? ActionTableViewCell else { return }
        
        let maxIndex = detailActiveNegativeEmotionVC.sortedActions.count
        var totalIsDone = 0
        
        for action in detailActiveNegativeEmotionVC.sortedActions {
            if action.isDone {
                totalIsDone += 1
            }
        }
        
        if let indexPath = actionTable.indexPath(for: cell) {
            
            if  action.isDone {
                detailActiveNegativeEmotionVC.sortedActions.remove(at: indexPath.row)
                detailActiveNegativeEmotionVC.sortedActions.insert(action, at: maxIndex - totalIsDone)
                actionTable.beginUpdates()
                actionTable.moveRow(at: indexPath, to: IndexPath(row: maxIndex - totalIsDone, section: 0))
                actionTable.endUpdates()
            } else {
                detailActiveNegativeEmotionVC.sortedActions.remove(at: indexPath.row)
                detailActiveNegativeEmotionVC.sortedActions.insert(action, at: maxIndex - totalIsDone - 1)
                actionTable.beginUpdates()
                actionTable.moveRow(at: indexPath, to: IndexPath(row: maxIndex - totalIsDone - 1, section: 0))
                actionTable.endUpdates()
            }
            DataManager.shared.editAction(action: action, isDone: !action.isDone)
        }
        setCheckmarkButtonImage()
        
    }
    
    func setCheckmarkButtonImage() {
        if (action.isDone) {
            checkmarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkmarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
}
