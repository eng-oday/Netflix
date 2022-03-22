//
//  MainCollectionViewCell.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    let stackView = UIStackView()
    
    let imageView: UIImageView = {
        
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let container: UIView = {
        
        let container = UIView()
        return container
        
    }()
    
    let playBtn: NetButton = {
        let Btn  = NetButton(backGorundColor: UIColor(red: 255, green: 255, blue: 255, alpha: 1) , tittle: "Play")
        return Btn
    }()
    
    let downloadBtn: NetButton = {
        let Btn  = NetButton(backGorundColor: UIColor(red: 255, green: 255, blue: 255, alpha: 1) , tittle: "Donwload")
        return Btn
    }()
    
    static let id = "cell"
   
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  contentView.backgroundColor = .systemGreen
        configureImageView()
        configureStackView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureImageView(){
        
        // code for gradient color
        let BackGroundView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.width + 20, height: contentView.height - 20))
        let gradient = CAGradientLayer()
        gradient.frame = BackGroundView.bounds
        let startColor = UIColor(red: 30/255, green: 113/255, blue: 79/255, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        BackGroundView.layer.insertSublayer(gradient, at: 0)
        
         addSubview(imageView)
        imageView.addSubview(BackGroundView)
        imageView.addSubview(container)
        container.addSubview(stackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints         = false
        container.translatesAutoresizingMaskIntoConstraints         = false
        stackView.translatesAutoresizingMaskIntoConstraints         = false
        BackGroundView.translatesAutoresizingMaskIntoConstraints    = false
        
        let padding :CGFloat   = 5
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: -padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: padding),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor , constant: -20),
            
            BackGroundView.topAnchor.constraint(equalTo: imageView.topAnchor),
            BackGroundView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: -padding),
            BackGroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            BackGroundView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            container.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            container.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: padding),
            container.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -padding),
            container.heightAnchor.constraint(equalToConstant: 70) ,
            
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    private func configure(image: UIImage){
        
        self.imageView.image = image
    }
    
    func configureStackView(){
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing       = 40
        
        stackView.addArrangedSubview(playBtn)
        stackView.addArrangedSubview(downloadBtn)
        
        
    }
    func configureData(ViewModel: MoviesViewModel?){
        
        guard let Model = ViewModel else {
            return
        }
        let imageURl = Model.poster_path
        APiCaller.shared.downloadImageView(from: imageURl) {[weak self] image in
            guard let self = self else {
                return
            }
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.configure(image: image)
            }
        }
    }
 
    
}
