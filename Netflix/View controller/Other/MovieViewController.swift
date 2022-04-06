//
//  MovieViewController.swift
//  Netflix
//
//  Created by Oday Dieg on 03/04/2022.
//

import UIKit

class MovieViewController: UIViewController {
    
    
    let ContentView = MoviePageView()
    
    var movie:Results?
    
    init(movie:Results) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetVC()
        fetchVideoTrailer()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationItem.largeTitleDisplayMode  = .never
        navigationController?.navigationBar.prefersLargeTitles      = false
    }
    
    
    private func SetVC(){
        view.backgroundColor    = .systemBackground
        view.addSubview(ContentView)
        ContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    
    private func fetchVideoTrailer(){
        
        guard let movie = movie else {
            return presentNetflixalertOnMainThread(title: "Something Went Wrong", message: "please Try Again later.", buttonTitle: "OK")
        }
        let group = DispatchGroup()
        group.enter()
        
        var trailerID:String?
        APiCaller.shared.GetMovieTrailer(with: movie.original_title ?? "" + " Trailer") { [weak self] result in
            guard let self = self else {return}
            
            defer{
                group.leave()
            }
                switch result {
                    
                case .success(let trailer):
                    trailerID = trailer.items[0].id.videoId
                    
                case .failure(let error):
                    self.presentNetflixalertOnMainThread(title: "OOPS", message: error.rawValue, buttonTitle: "ok")
                }

            
        }
        group.notify(queue: .main){
            
            guard let trailerid = trailerID else {
                return
            }
            self.configure(with: trailerid)
            
        }
        
    }

    private func configure(with id : String){
        
        let tittle = movie?.original_title ?? "No Tittle"
        guard let overview = movie?.overview else {
            return
        }
        ContentView.Configure(with: PreviewViewModel(tittle: tittle, overView: overview, id: id))
        
    }
    
    
}
