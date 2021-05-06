//
//  NegativeEmotionInfoPopupViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 04/05/21.
//

import UIKit

class NegativeEmotionInfoPopupViewController: UIViewController {

    @IBOutlet weak var descContainer: UIScrollView!
    @IBOutlet weak var negativeEmotionNameLabel: UILabel!
    @IBOutlet weak var negativeEmotionDescLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var exitView: UIView!
    
    var isConfirmation = true
    var negativeEmotion: NegativeEmotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descContainer.contentSize = CGSize(width: 250, height: 380.5)
        negativeEmotionNameLabel.text = negativeEmotion?.name
        negativeEmotionDescLabel.text = negativeEmotion?.desc
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        exitView.addGestureRecognizer(gesture)
    }
    
    @IBAction func confirmationButtonPressed(_ sender: UIButton) {
        if isConfirmation {
            if (!DataManager.shared.HomeVC!.isActiveNegativeEmotionsExist) {
                DataManager.shared.activateNegativeEmotion(negativeEmotion: negativeEmotion!)
                DataManager.shared.HomeVC!.view = ActiveNegativeEmotionExistView(frame: CGRect(x: 0, y: 0, width: 390, height: 723))
                DataManager.shared.HomeVC!.navigationController?.setNavigationBarHidden(false, animated: false)
                DataManager.shared.HomeVC!.viewDidLoad()
            } else {
                DataManager.shared.activateNegativeEmotion(negativeEmotion: negativeEmotion!)
            }
            DataManager.shared.HomeVC?.negativeEmotionTableView.reloadData()
        }
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }

    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
}
