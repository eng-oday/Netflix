//
//  AlertVC.swift
//  Netflix
//
//  Created by Oday Dieg on 22/03/2022.
//

import UIKit

class AlertVC: UIViewController {

    
    let containerView :UIView = {
        let container = UIView()
        container.layer.cornerRadius                            = 16
        container.layer.masksToBounds                           = true
        container.clipsToBounds                                 = true
        container.translatesAutoresizingMaskIntoConstraints     = false
        container.backgroundColor                               = .systemBackground
        container.layer.borderWidth                             = 2
        container.layer.borderColor                             = UIColor.white.cgColor
        return container
    }()
    
    let alertTittle:UILabel = {
        let tittle = UILabel()
        tittle.textAlignment                                    = .center
        tittle.font                                             = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tittle.translatesAutoresizingMaskIntoConstraints        = false
        tittle.textColor                                        = .label
        tittle.numberOfLines                                    = 1
        tittle.adjustsFontSizeToFitWidth                        = true
        tittle.minimumScaleFactor                               = 0.9
        tittle.lineBreakMode                                    = .byTruncatingTail
        return tittle
        
    }()
    
    let alertBody:UILabel = {
        
       let body = UILabel()
        body.textAlignment                                      = .center
        body.font                                               = UIFont.preferredFont(forTextStyle: .body)
        body.translatesAutoresizingMaskIntoConstraints          = false
        body.textColor                                          = .secondaryLabel
        body.numberOfLines                                      = 4
        body.adjustsFontSizeToFitWidth                          = true
        body.minimumScaleFactor                                 = 0.75
        body.lineBreakMode                                      = .byWordWrapping
        return body
    }()
    
    let actionButton:UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints        = false
        button.layer.cornerRadius                               = 10
        button.layer.masksToBounds                              = true
        button.clipsToBounds                                    = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor                                  = .systemPink
        button.titleLabel?.font                                 = UIFont.preferredFont(forTextStyle: .headline)
        return button
        
    }()
    
    let padding:CGFloat     = 20
    
    var tittle:String?
    var bodyMessage:String?
    var buttonTittle:String?
    
    
    init(tittle:String,bodyMessage:String,buttonTittle:String) {
        super.init(nibName: nil, bundle: nil)
        self.tittle         = tittle
        self.bodyMessage    = bodyMessage
        self.buttonTittle   = buttonTittle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureAlertTittle()
        configureActionButton()
        configureAlertBody()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView(){
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    private func configureAlertTittle(){
        containerView.addSubview(alertTittle)
        
        alertTittle.text        =  tittle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            alertTittle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            alertTittle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertTittle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertTittle.heightAnchor.constraint(equalToConstant: 25)
        
        ])
    }
    
    
    private func configureAlertBody(){
        containerView.addSubview(alertBody)
        
        alertBody.text      = bodyMessage ?? "Please Try again Later"
        NSLayoutConstraint.activate([
            alertBody.topAnchor.constraint(equalTo: alertTittle.bottomAnchor, constant: 8),
            alertBody.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertBody.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertBody.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    private func configureActionButton(){
        containerView.addSubview(actionButton)
        
        actionButton.setTitle("OK", for: .normal)
        actionButton.addTarget(self, action: #selector(DismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func DismissVC(){
        self.dismiss(animated: true)
    }
    
}
