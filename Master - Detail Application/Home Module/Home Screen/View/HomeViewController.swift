//
//  HomeViewController.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        configureSearchBar()
        configureTableView()
        initMVVM()
        super.viewDidLoad()
    }
   
    //MARK:- init MVVM
    func initMVVM(){
        viewModel.getMovies()
        viewModel.reloadMoviesTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.homeTableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK:- init TableView
    func configureTableView() {
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    //MARK:- TableViewDelegation methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowsInSectionCount(sectionNum: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getMoviesSectionCount()
    }
    
    //MARK:- TableViewDataSource methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionHeader(sectionNum: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel.getCellData(row: indexPath.row, sectionNum: indexPath.section).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        homeDetailsViewController.movie = viewModel.movies[indexPath.row]
        homeDetailsViewController.modalPresentationStyle = .fullScreen
        self.present(homeDetailsViewController, animated: true, completion: nil)
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(searchText: searchText)
    }
}
