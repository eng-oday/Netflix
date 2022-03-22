//
//  SearchVC.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import UIKit

class SearchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    private func setViewController(){
        view.backgroundColor    = .systemBackground
        title                   = "Search"
        navigationController?.navigationItem.largeTitleDisplayMode  = .always
        navigationController?.navigationBar.prefersLargeTitles      = true

        
    }
    
    
}
