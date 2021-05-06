//
//  ChooseNegativeEmotionPopupViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 04/05/21.
//

import UIKit

class ChooseNegativeEmotionPopupViewController: UIViewController {

    @IBOutlet weak var exitView: UIView!
    @IBOutlet weak var anxiousOption: UIStackView!
    @IBOutlet weak var sadOption: UIStackView!
    @IBOutlet weak var overthinkOption: UIStackView!
    @IBOutlet weak var exhaustedOption: UIStackView!
    
    var negativeEmotionOptions: [UIStackView] = []
    var negativeEmotions: [NegativeEmotion] = []
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        negativeEmotions = DataManager.shared.getNegativeEmotions()
        negativeEmotionOptions = [anxiousOption, sadOption, overthinkOption, exhaustedOption]
        
        let tapGestureForExit = UITapGestureRecognizer(target: self, action: #selector(dismiss(_:)))
        exitView.addGestureRecognizer(tapGestureForExit)
        
        for (i, negativeEmotionOption) in negativeEmotionOptions.enumerated() {
            if (!negativeEmotions[i].isActive) {
                negativeEmotionOption.addGestureRecognizer(setNegativeEmotionOptionGesture())
            } else {
                negativeEmotionOption.alpha = 0.5
            }
        }
    }
    
    // Karena satu class recognizer gak bisa dipakai untuk bnyak view, so kita bikinin aja fungsi untuk generate si recognizer wkwkwk, mantapp

    func setNegativeEmotionOptionGesture() -> UITapGestureRecognizer {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(popup(_:)))
        
        return tapRecognizer
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer) {
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    @objc func popup(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else {
            fatalError()
        }
        let negativeEmotionInfoPopupViewController = NegativeEmotionInfoPopupViewController(nibName: "NegativeEmotionInfoPopupView", bundle: nil)
        negativeEmotionInfoPopupViewController.negativeEmotion = negativeEmotions[index]
        negativeEmotionInfoPopupViewController.modalPresentationStyle = .overCurrentContext
        
        self.present(negativeEmotionInfoPopupViewController, animated: false, completion: nil)
        
    }
}
