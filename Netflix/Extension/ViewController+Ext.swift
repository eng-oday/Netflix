//
//  ViewController+Ext.swift
//  Netflix
//
//  Created by Oday Dieg on 22/03/2022.
//

import UIKit

extension UIViewController {
    
    func presentNetflixalertOnMainThread(title:String,message:String,buttonTitle:String){
        
        DispatchQueue.main.async {
            
            let alertVc                     = AlertVC(tittle: title, bodyMessage: message, buttonTittle: buttonTitle)
            alertVc.modalPresentationStyle  = .overFullScreen
            alertVc.modalTransitionStyle    = .crossDissolve
           
            self.present(alertVc, animated: true)
            
        }
        
    }
}
