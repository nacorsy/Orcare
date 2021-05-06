//
//  ActionRecordTableViewCell.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 06/05/21.
//

import UIKit

class ActionRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var negativeEmotionNameLabel: UILabel!
    @IBOutlet weak var actionRecordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actionRecordLabel.text = ""
        layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
        
        // reset (hide) the checkmark label
        self.actionRecordLabel.text = ""

    }
    
}
