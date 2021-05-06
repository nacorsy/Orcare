//
//  ActionCollectionViewCell.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 06/05/21.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actionButton: UIButton!
    var isActionButtonTapped = false
    
    var action: Action!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actionButton.layer.cornerRadius = layer.frame.height / 2
    }

    @IBAction func actionButtonPressed(_ sender: UIButton) {
        guard var currentTitle = sender.currentTitle else { return }
        if isActionButtonTapped {
            DataManager.shared.editAction(action: action, totalSolved: 1)
            currentTitle.removeFirst()
            sender.setTitle("\(currentTitle)", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9098039216, blue: 0.8745098039, alpha: 1)
        } else {
            DataManager.shared.editAction(action: action, totalSolved: -1)
            sender.setTitle("✅ \(currentTitle)", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8392156863, blue: 0.737254902, alpha: 1)
        }
        isActionButtonTapped = !isActionButtonTapped
    }
}
