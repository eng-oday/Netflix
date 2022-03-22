//
//  NetButton.swift
//  Netflix
//
//  Created by Oday Dieg on 21/03/2022.
//

import UIKit

class NetButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    convenience init(backGorundColor:UIColor , tittle: String) {
        self.init(frame: .zero)
        self.backgroundColor = backGorundColor
        self.setTitle(tittle, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
        layer.cornerRadius          = 3
        layer.masksToBounds         = true
        clipsToBounds               = true
        layer.borderWidth           = 2
        layer.borderColor           = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        setTitleColor(.white, for: .normal)
        titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.black, for: .normal)
        
        
    }
    
    func set(backGroundColor: UIColor , tittle: String){
        self.backgroundColor = backGroundColor
        self.setTitle(tittle, for: .normal)
        
    }
    
}
