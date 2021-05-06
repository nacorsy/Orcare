//
//  HomeViewController.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 03/05/21.
//

import UIKit

class HomeViewController: UIViewController {

    var actions: [Action] = []
    
    var isActiveNegativeEmotionsExist = DataManager.shared.getActiveNegativeEmotions().count > 0
    
    var activeNegativeEmotionExistView: ActiveNegativeEmotionExistView {
        return view as! ActiveNegativeEmotionExistView
    }
    
    var negativeEmotionTableView: UITableView!
    
    let addActiveNegativeEmotionButton = AddActiveNegativeEmotionButton(frame: CGRect(x: 0, y: 0, width: 234, height: 45))
    
    override func loadView() {
        if isActiveNegativeEmotionsExist {
            navigationController?.setNavigationBarHidden(false, animated: false)
            view = ActiveNegativeEmotionExistView(frame: CGRect(x: 0, y: 0, width: 390, height: 723))
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
            view = EmptyActiveNegativeEmotionView(frame: CGRect(x: 0, y: 0, width: 390, height: 615))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3238343, green: 0.2315784991, blue: 0.46924752, alpha: 1)
        if let safeNegativeEmotionTableView = negativeEmotionTableView {
            safeNegativeEmotionTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isActiveNegativeEmotionsExist = DataManager.shared.getActiveNegativeEmotions().count > 0
        
        DataManager.shared.HomeVC = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3238343, green: 0.2315784991, blue: 0.46924752, alpha: 1)
        
        let buttonAttr: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Poppins-Regular", size: 14)!
        ]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Action Records", style: .plain, target: self, action: #selector(recordButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(buttonAttr, for: .normal)
        
        addActiveNegativeEmotionButton.center = CGPoint(x: self.view.frame.size.width / 2, y: 720)
        addActiveNegativeEmotionButton.addTarget(self, action: #selector(self.addActiveNegativeEmotionButtonPressed), for: .touchUpInside)
        view.addSubview(addActiveNegativeEmotionButton)
        
        if (isActiveNegativeEmotionsExist) {
            negativeEmotionTableView = activeNegativeEmotionExistView.negativeEmotionTableView

            negativeEmotionTableView.delegate = self
            negativeEmotionTableView.dataSource = self

            negativeEmotionTableView.register(UINib(nibName: "ActiveNegativeEmotionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActiveNegativeEmotionCell")
            
            if (negativeEmotionTableView.contentSize.height < negativeEmotionTableView.frame.size.height) {
                negativeEmotionTableView.isScrollEnabled = false
            } else {
                negativeEmotionTableView.isScrollEnabled = true
            }
        }
    }
    
    @objc func recordButtonPressed(_ sender: UIBarButtonItem) {
        guard let recordVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "RecordViewController") as RecordViewController? else { return }
        
        recordVC.negativeEmotions = DataManager.shared.getNegativeEmotions()
        
        navigationController?.pushViewController(recordVC, animated: true)
    }
    
    func setupNegativeEmotionTable() {
        
    }
    
    @objc func addActiveNegativeEmotionButtonPressed(sender: UIButton!) {
        let chooseNegativeEmotionPopupVC = ChooseNegativeEmotionPopupViewController(nibName: "ChooseNegativeEmotionPopupView", bundle: nil)
        
        let nav = UINavigationController(rootViewController: chooseNegativeEmotionPopupVC)
        nav.modalPresentationStyle = .overCurrentContext
        
        self.present(nav, animated: false, completion: nil)
    }

}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.getActiveNegativeEmotions().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveNegativeEmotionCell", for: indexPath) as! ActiveNegativeEmotionTableViewCell
        
        let negativeEmotion = DataManager.shared.getActiveNegativeEmotions()[indexPath.section]
        actions = DataManager.shared.getActions(negativeEmotion: negativeEmotion)
        let totalDoneActions = DataManager.shared.countDoneAction(from: negativeEmotion.actions!)
    
        cell.negativeEmotionNameLabel.text = negativeEmotion.name
        cell.negativeEmotionActionIndicator.text = "\(totalDoneActions) / \(String(actions.count)) actions"
        cell.negativeEmotionImage.image = UIImage(named: negativeEmotion.image ?? "")
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        guard let detailActiveNegativeEmotionVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DetailActiveNegativeEmotionViewControllerIdentifier") as DetailActiveNegativeEmotionViewController? else {
            return
        }
        
        detailActiveNegativeEmotionVC.negativeEmotion = DataManager.shared.getActiveNegativeEmotions()[indexPath.section]
        
        navigationController?.pushViewController(detailActiveNegativeEmotionVC, animated: true)
    }
}
