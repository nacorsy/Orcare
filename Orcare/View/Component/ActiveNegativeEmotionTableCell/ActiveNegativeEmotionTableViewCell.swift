//
//  ActiveNegativeEmotionTableViewCell.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 03/05/21.
//

import UIKit

class ActiveNegativeEmotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var negativeEmotionNameLabel: UILabel!
    @IBOutlet weak var negativeEmotionActionIndicator: UILabel!
    @IBOutlet weak var negativeEmotionImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
