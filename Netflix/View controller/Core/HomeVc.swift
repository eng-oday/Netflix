//
//  ViewController.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import UIKit

class HomeVc: UIViewController {
    
    
    
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout  { sectionIndex,_ -> NSCollectionLayoutSection? in
            return HomeVc.createSection(section: sectionIndex)
        })
    
    private var sections = [sectionType]()
    var popularMovies       = [Results]()
    var trendingMovies      = [Results]()
    var trendingTV          = [Results]()
    var upComing            = [Results]()
    var topRated            = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        SetNavigationController()
        configureCollectioView()
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setViewController(){
        view.backgroundColor  = .systemBackground
    }
    private func configureCollectioView(){
        view.addSubview(collectionView)
        collectionView.delegate                 = self
        collectionView.dataSource               = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
        collectionView.register(TopicCollectionCell.self, forCellWithReuseIdentifier: TopicCollectionCell.id)
        
        collectionView.register(TittleHeaderCollectionReusableView.self,
                                
                                forSupplementaryViewOfKind:                 UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier:                        TittleHeaderCollectionReusableView.identifier
        )
    }
    
    private func SetNavigationController(){
        
        let profileBtn: UIBarButtonItem = {
            let profile = UIBarButtonItem(image:navigationBarImage.profile , style: .done, target: self, action: #selector(profileDidTapped))
            return profile
        }()
        
        let playBtn:UIBarButtonItem = {
            let play = UIBarButtonItem(image:navigationBarImage.play , style: .done, target: self, action: #selector(PlayButtonDidTapped))
            return play
        }()
        
        let logoImage:UIBarButtonItem = {
            var logo = navigationBarImage.logo
            logo = logo?.withRenderingMode(.alwaysOriginal)         // to keep image with own colors
            let play = UIBarButtonItem(image: logo, style: .done, target: self, action: nil)
            play.isEnabled = false
            return play
        }()
        navigationItem.rightBarButtonItems                          = [profileBtn,playBtn]
        navigationController?.navigationBar.tintColor               = .label
        navigationItem.leftBarButtonItem                            = logoImage
    }
    
    @objc func profileDidTapped(){
        presentNetflixalertOnMainThread(title: "wrong user", message: "there is no user in this APP ", buttonTitle: "OK")
    }
    @objc func PlayButtonDidTapped(){
        
    }
    
    

    
    private func fetchData(){
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
   
        var Popularmovies:Movies?
        var trendingTV : Movies?
        var trendingMovies:Movies?
        var upComig:Movies?
        var topRated:Movies?
        
        
        APiCaller.shared.getPopular { [weak self] result in
            guard let self = self else {return}
            defer{
                group.leave()
            }
            switch result{
            case .success(let data):
                Popularmovies = data
            case .failure(let error):
                self.presentNetflixalertOnMainThread(title: "OOPS ☹️", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        APiCaller.shared.getTrendingMovies { [weak self] result in
            
            guard let self = self else {return}
            defer{
                group.leave()
            }
            switch result{
            case .success(let data):
                trendingMovies = data
            case .failure(let error):
                self.presentNetflixalertOnMainThread(title: "OOPS ☹️", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
        
        APiCaller.shared.getTrendingTV { [weak self] result in
            
            guard let self = self else {return}
            defer{
                group.leave()
            }
            switch result{
            case .success(let data):
                trendingTV = data
            case .failure(let error):
                self.presentNetflixalertOnMainThread(title: "OOPS ☹️", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
        
        APiCaller.shared.getUpcoming { [weak self] result in
            
            guard let self = self else {return}
            defer{
                group.leave()
            }
            switch result{
            case .success(let data):
                upComig = data
            case .failure(let error):
                self.presentNetflixalertOnMainThread(title: "OOPS ☹️", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
        APiCaller.shared.getTopRated { [weak self] result in
            
            guard let self = self else {return}
            defer{
                group.leave()
            }
            switch result{
            case .success(let data):
                topRated = data
            case .failure(let error):
                self.presentNetflixalertOnMainThread(title: "OOPS ☹️", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
        
        
        
        group.notify(queue: .main){
            guard let popularMovie              = Popularmovies?.results ,
                  let trendingMovies            = trendingMovies?.results ,
                  let trendingTV                = trendingTV?.results,
                  let upComing                  = upComig?.results,
                  let topRated                  = topRated?.results
            else {
                return
            }
            self.appendTosections(popular: popularMovie,trendingMovies: trendingMovies, trendingTV: trendingTV, upcoming: upComing,topRated: topRated)
            
        }
        
    }
    
    
    func appendTosections(popular:[Results],trendingMovies:[Results],trendingTV:[Results] , upcoming:[Results], topRated:[Results]){
        
        self.popularMovies      = popular
        self.trendingMovies     = trendingMovies
        self.trendingTV         = trendingTV
        self.upComing           = upcoming
        self.topRated           = topRated
        
        
    
        sections.append(.MainPoster(ViewModel: trendingMovies.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "No tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image", vote_average: $0.vote_average)
        })))
        
        sections.append(.trendingMovies(ViewModel: trendingMovies.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "No tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image", vote_average: $0.vote_average)
        })))
        
      
        sections.append(.trendingTV(ViewModel: trendingTV.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "NO Tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image" , vote_average: $0.vote_average)
        })))
        
        sections.append(.popular(ViewModel: popular.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "No tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image", vote_average: $0.vote_average)
        })))
        
        sections.append(.upComing(ViewModel: upcoming.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "No tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image", vote_average: $0.vote_average)
        })))
        
        sections.append(.topRated(ViewModel: topRated.compactMap({
            return MoviesViewModel(id: $0.id, original_language: $0.original_language, title: $0.original_title ?? "No tittle", overview: $0.overview, poster_path: $0.poster_path ?? "NO image", vote_average: $0.vote_average)
        })))
        
        collectionView.reloadData()
    }
    
}

//MARK: - CollectionView Setup

extension HomeVc: UICollectionViewDelegate , UICollectionViewDataSource {
    
    enum sectionType {
        
        
        case MainPoster( ViewModel:[MoviesViewModel])
        case trendingMovies( ViewModel:[MoviesViewModel])
        case trendingTV(ViewModel:[MoviesViewModel])
        case popular(ViewModel: [MoviesViewModel])
        case upComing(ViewModel:[MoviesViewModel])
        case topRated(ViewModel:[MoviesViewModel])
        
        
        var title:String{
            
            switch self{
            case .MainPoster:
                return HeadersTittle.MainPoster
            case .trendingMovies:
                return HeadersTittle.trendingMovies
            case .trendingTV:
                return HeadersTittle.trendingTV
            case .popular:
                return HeadersTittle.popular
            case .upComing:
                return HeadersTittle.comingSoon
            case .topRated:
                return HeadersTittle.topRated
            }
        }
    }
    
    
    static func createSection(section : Int) -> NSCollectionLayoutSection {
        
        //headerview
        let supplementaryView  = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        switch section {
            
            //first Section In Collection
        case 0 :
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.54))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
            
            //Second Section In CollectionView
        case 1... :
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem( layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(150),heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal( layoutSize: horizontalGroupSize , subitem: item, count: 1)
            
            //section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryView
            return section
            
            // Default Section
        default:
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem( layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(360))
            let group = NSCollectionLayoutGroup.vertical( layoutSize: groupSize , subitem: item, count:3)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
            
        case .MainPoster(ViewModel: _):
            return 1
        case .trendingMovies(ViewModel: let trendingMovies):
            return trendingMovies.count
        case .trendingTV(ViewModel: let trendingTV):
            return trendingTV.count
        case .popular(ViewModel: let popular):
            return popular.count
        case .upComing(ViewModel: let upComing):
            return upComing.count
        case .topRated(ViewModel: let topRated):
            return topRated.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section]
        
        switch section {
            
        case .MainPoster(ViewModel: let mainMoview):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
             let randomMovie = mainMoview.randomElement()
            cell.configureData(ViewModel: randomMovie)
            return cell
            
        case .trendingMovies(ViewModel: let trendingMovies):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionCell.id, for: indexPath) as? TopicCollectionCell else {
                return UICollectionViewCell()
            }
            let model = trendingMovies[indexPath.row]
            cell.configureData(ViewModel: model)
            
            return cell
            
        case .trendingTV(ViewModel: let trendingTV):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionCell.id, for: indexPath) as? TopicCollectionCell else {
                return UICollectionViewCell()
            }
            let model = trendingTV[indexPath.row]
            cell.configureData(ViewModel: model)
            return cell
        case .popular(ViewModel: let popular):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionCell.id, for: indexPath) as? TopicCollectionCell else {
                return UICollectionViewCell()
            }
            let model = popular[indexPath.row]
            cell.configureData(ViewModel: model)
            return cell
            
        case .upComing(ViewModel: let upComing):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionCell.id, for: indexPath) as? TopicCollectionCell else {
                return UICollectionViewCell()
            }
            
            let model = upComing[indexPath.row]
            cell.configureData(ViewModel: model)
            return cell
            
        case .topRated(ViewModel: let topRated):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionCell.id, for: indexPath) as? TopicCollectionCell else {
                return UICollectionViewCell()
            }
            let model = topRated[indexPath.row]
            cell.configureData(ViewModel: model)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind ,
            withReuseIdentifier: TittleHeaderCollectionReusableView.identifier,
            for: indexPath
        )  as? TittleHeaderCollectionReusableView ,
              kind == UICollectionView.elementKindSectionHeader
        else{
            return UICollectionReusableView()
        }
        
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with:title)
        return header
    }
    
    
}
