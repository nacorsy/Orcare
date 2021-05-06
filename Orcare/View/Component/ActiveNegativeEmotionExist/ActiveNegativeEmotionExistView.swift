//
//  NegativeEmotionExistView.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 03/05/21.
//

import UIKit

class ActiveNegativeEmotionExistView: UIView {
    @IBOutlet weak var negativeEmotionTableView: UITableView!
    
    let kCONTENT_XIB_NAME = "ActiveNegativeEmotionExistView"
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)![0] as! UIView
        
        addSubview(viewFromXib)
    }

}
