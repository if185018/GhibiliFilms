//
//  FilmVC.swift
//  GhibliPractice
//
//  Created by C4Q on 10/1/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

class FilmVC: UITableViewController {

    
    private var films = [Film]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    private func loadData() {
        FilmAPIClient.shared.getFilms { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let filmsFromOnline):
                    self.films = filmsFromOnline
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        let film = films[indexPath.row]
        cell.titleLabel.text = film.title
        cell.filmImageView.image = UIImage(named: film.title)
        cell.optionsButton.tag = indexPath.row
        cell.delegate = self
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

 

}
extension FilmVC: FilmCellDelegate {
    func actionSheet(tag: Int) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "Add to favorites", style: .default) { (action) in
            let film = self.films[tag]
            try? FilmsPersistenceManager.manager.saveFilm(film: film)
        
        }
         let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(addAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
                    
    }
    
    
}
