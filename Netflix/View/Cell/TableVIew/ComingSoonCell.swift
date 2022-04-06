//
//  ComingSoonCell.swift
//  Netflix
//
//  Created by Oday Dieg on 05/04/2022.
//

import UIKit

class ComingSoonCell: UITableViewCell {
    
    
    static let identifier          = "ComingSoonCell"
    
    private let posterImage:UIImageView = {
        
        let image = UIImageView()
        image.layer.cornerRadius        = 5
        image.layer.masksToBounds       = true
        image.clipsToBounds             = true
        image.contentMode               = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    private let containerView:UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints   = false
        return view
        
    }()
    
    private let movieName:UILabel = {
       
        let label = UILabel()
        label.textColor         = .label
        label.text              = "Spider Man-No Way To Home"
        label.textAlignment     = .left
        label.numberOfLines     = 1
        label.lineBreakMode     = .byTruncatingTail
        label.font              = UIFont.systemFont(ofSize: 16, weight: .bold)
       // label.backgroundColor   = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let rateLabel:UILabel = {
       let label = UILabel()
        label.textColor         = .label
        label.text              = "Rate: 8.9"
        label.textAlignment     = .left
        label.numberOfLines     = 1
        label.lineBreakMode     = .byTruncatingTail
        label.font              = UIFont.systemFont(ofSize: 16, weight: .semibold)
      //  label.backgroundColor   = .systemMint
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playBtn:UIButton = {
        
       let btn = UIButton()
       // btn.backgroundColor         = .systemPink
        btn.layer.cornerRadius      = 20
        btn.layer.masksToBounds     = true
        btn.clipsToBounds           = true
        btn.tintColor               = .label
        btn.contentMode             = .scaleToFill
        btn.setImage(UIImage(systemName: Image.playBtn, withConfiguration:UIImage.SymbolConfiguration(pointSize: 34, weight: .regular)), for: .normal)
        btn.addTarget(self, action: #selector(PLayBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetView()
    }
    
    @objc private func PLayBtnTapped(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetView(){
        
        addSubview(posterImage)
        addSubview(containerView)
        containerView.addSubview(movieName)
        containerView.addSubview(rateLabel)
        containerView.addSubview(playBtn)
        
        NSLayoutConstraint.activate([
        
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            containerView.widthAnchor.constraint(equalToConstant: contentView.width - posterImage.width),
            containerView.heightAnchor.constraint(equalToConstant: 140),
            
            movieName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor , constant: -20),
            movieName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieName.widthAnchor.constraint(equalToConstant: contentView.width - 90),
            movieName.heightAnchor.constraint(equalToConstant: 40),
            
            rateLabel.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            rateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            rateLabel.widthAnchor.constraint(equalTo: movieName.widthAnchor),
            rateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            playBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            playBtn.leadingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 15),
            playBtn.widthAnchor.constraint(equalToConstant: 40),
            playBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
    func ConfigureWith(with ViewModel: ComingSoonCellViewModel){
        
        let imageURl = ViewModel.posterImage
        APiCaller.shared.downloadImageView(from: imageURl) {[weak self] image in
            guard let self = self else {
                return
            }
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.posterImage.image   = image
            }
        }
        movieName.text  =   ViewModel.tittle
        rateLabel.text  = "Rating: \(ViewModel.rating)"
        
    }
    
    
    
    
}
