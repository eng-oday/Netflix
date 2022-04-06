//
//  ComingSoonVc.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import UIKit

class ComingSoonVc: UIViewController {
    
    
    private let tableView = UITableView()
    

    var upComing = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        ConfigureTableView()
    }

    
    private func setViewController(){
        view.backgroundColor    = .systemBackground
        title                   = "UP Coming"
        navigationController?.navigationItem.largeTitleDisplayMode  = .always
        navigationController?.navigationBar.prefersLargeTitles      = true

        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func ConfigureTableView(){
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints         = false
        tableView.frame                                             = view.bounds
        tableView.delegate                                          = self
        tableView.dataSource                                        = self
        tableView.register(ComingSoonCell.self, forCellReuseIdentifier: ComingSoonCell.identifier)
        
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func ListenToNotificationCenter(_ Notification:Notification){
        
        if let Data = Notification.object as? [Results] {
            self.upComing = Data
            print("Done")
        }else{
            presentNetflixalertOnMainThread(title: "am Sorry", message: "Something went Wrong in Data Please Try Again Later 😔. ", buttonTitle: "OK")
        }
        
    }
    
}


extension ComingSoonVc:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComing.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComingSoonCell.identifier, for: indexPath) as? ComingSoonCell else {
            return UITableViewCell()
        }
        let item = upComing[indexPath.row]
        cell.ConfigureWith(with: ComingSoonCellViewModel(tittle: item.original_title ?? "", posterImage: item.poster_path ?? "", rating: String(item.vote_average)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = upComing[indexPath.row]
            let destVC = MovieViewController(movie: item)
            destVC.title    = item.original_title!
            self.navigationController?.pushViewController(destVC, animated: true)
        
    }
}
