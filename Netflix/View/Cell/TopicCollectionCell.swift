//
//  TopicCollectionCell.swift
//  Netflix
//
//  Created by Oday Dieg on 21/03/2022.
//

import UIKit

class TopicCollectionCell: UICollectionViewCell {
    
    static let id = "TopicCollectionCell"
    
   private let posterImage: UIImageView = {
        
        let image = UIImageView()
       image.contentMode    = .scaleAspectFill
       image.clipsToBounds = true
       image.layer.masksToBounds = true
       return image
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImage(){
        
        contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImage.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        
        ])
    }
    
    func configureData(ViewModel: MoviesViewModel){
        
        let imageURl = ViewModel.poster_path
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
    
    private func configure(image: UIImage){
        self.posterImage.image = image
    }
    
}
