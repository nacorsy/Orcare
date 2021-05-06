//
//  AddActiveNegativeEmotionButton.swift
//  Orcare
//
//  Created by Yossan Sandi Rahmadi on 04/05/21.
//

import UIKit

class AddActiveNegativeEmotionButton: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setTitle("I have a negative emotion", for: .normal)
        titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        titleEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
//        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        backgroundColor = #colorLiteral(red: 0.3238343, green: 0.2315784991, blue: 0.46924752, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
