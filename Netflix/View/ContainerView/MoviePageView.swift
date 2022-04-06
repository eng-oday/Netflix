//
//  MoviePageView.swift
//  Netflix
//
//  Created by Oday Dieg on 03/04/2022.
//

import UIKit
import WebKit

class MoviePageView: UIView {

    let webView: WKWebView = {
        
       let webView = WKWebView()
        webView.backgroundColor = .systemBackground
        webView.isOpaque        = false
        return webView
    }()
    
    let movieTitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor     = .label
        label.font          = UIFont.systemFont(ofSize: 23, weight: .semibold)
        return label
        
    }()
    
    
    let movieDescLabel:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor     = .label
        label.clipsToBounds = true
        label.baselineAdjustment    = .alignBaselines
        label.adjustsFontSizeToFitWidth = true
        label.font          = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        return label
        
    }()
    
    let downloadBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius          = 16
        btn.layer.masksToBounds         = true
        btn.clipsToBounds               = true
        btn.layer.borderWidth           = 2
        btn.layer.borderColor           = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
        btn.setTitle("Download", for: .normal)
        btn.backgroundColor             = .systemPink
        btn.addTarget(self, action: #selector(DonwloadBtnTapped), for: .touchUpInside)
        return btn
        
    }()
    
    @objc private func DonwloadBtnTapped(){}

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureElements()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    let font = UIFont(name: "Helvetica", size: 20.0)

    private func configureElements(){
        
        addSubview(webView)
        addSubview(movieTitleLabel)
        addSubview(movieDescLabel)
        addSubview(downloadBtn)
        
     
        
        webView.translatesAutoresizingMaskIntoConstraints           = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints   = false
        movieDescLabel.translatesAutoresizingMaskIntoConstraints    = false
        downloadBtn.translatesAutoresizingMaskIntoConstraints       = false
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
        
            webView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            webView.topAnchor.constraint(equalTo: self.topAnchor),
            webView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 350),
            
            
            movieTitleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: padding),
            movieTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            movieDescLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            movieDescLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieDescLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          //  movieDescLabel.heightAnchor.constraint(equalToConstant: 200),
            
            
            downloadBtn.topAnchor.constraint(equalTo: movieDescLabel.bottomAnchor, constant: 10),
            downloadBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downloadBtn.widthAnchor.constraint(equalToConstant: 140),
            downloadBtn.heightAnchor.constraint(equalToConstant: 40)
        
        ])
    }

    func Configure(with Movie:PreviewViewModel){
        
        movieTitleLabel.text        = Movie.tittle
        movieDescLabel.text         = Movie.overView
        
        
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(Movie.id)") else {
            return
        }
        webView.load(URLRequest(url: url))
        
    }
    

}
