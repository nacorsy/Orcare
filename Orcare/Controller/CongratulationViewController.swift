//
//  CongratulationViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 06/05/21.
//

import UIKit

class CongratulationViewController: UIViewController {
    @IBOutlet weak var actionCollectionView: UICollectionView!
    
    var negativeEmotion: NegativeEmotion!
    var actions: [Action] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let buttonAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-Regular", size: 20)!
        ]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(buttonAttr, for: .normal)
        self.navigationItem.setHidesBackButton(true, animated: false)

        actionCollectionView.dataSource = self
        
        actionCollectionView.register(UINib(nibName: "ActionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActionCollectionCell")
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem) {
        DataManager.shared.deactivateNegativeEmotion(negativeEmotion: negativeEmotion)
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension CongratulationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return actions.count
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionCollectionCell", for: indexPath) as! ActionCollectionViewCell
        
        cell.action = actions[indexPath.row]
        cell.actionButton.setTitle(actions[indexPath.row].title, for: .normal)
        
        return cell
    }
    
    
}
