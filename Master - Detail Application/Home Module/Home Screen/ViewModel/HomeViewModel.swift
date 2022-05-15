//
//  HomeViewModel.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import Foundation
class HomeViewModel: NSObject {
    //MARK:- Properties
    var movies: [Movie] = [] {
        didSet {
            filterMovies = movies
        
        }
    }
    
    var filterMovies: [Movie] = []
    var reloadMoviesTableViewClosure: (()->())?
    var currentMovies: [Movie] = []
    
    var categoriesMovies: Dictionary<Int, [Movie]> = [:] {
        didSet {                reloadMoviesTableViewClosure?()
        }
    }
    
    private let services: HomeServicesProtocol
    
    
    //MARK:- Init
    init(services: HomeServicesProtocol = HomeServices()) {
        self.services = services
    }
    
    //MARK:- Data Presentation
    // handling cells and tableViewData from loaded data
    func getMoviesSectionCount() -> Int {
        return categoriesMovies.count
    }
    
    func getCellData(row: Int, sectionNum: Int) -> Movie
    {
        currentMovies = Array(categoriesMovies)[sectionNum].value.sorted(by: { $0.rating > $1.rating })
        return currentMovies[row]
    }
    
    func getRowsInSectionCount(sectionNum: Int) -> Int
    {
        let count = Array(categoriesMovies)[sectionNum].value.count
      
        return count > 5 ? 5 : count
    }
    
    func getSectionHeader(sectionNum: Int) -> String
    {
        return "\(Array(categoriesMovies.keys)[sectionNum])"
    }
    
    
    //MARK:- Load Data
    // get movies from api
    func getMovies() {
        guard let movies = services.loadMovies() else { return }
        self.movies = movies
        categoriesMovie()
        
    }
    
    // grouping and categories data by year
    func categoriesMovie() {
        let categoriesedMovieList  = Dictionary(grouping: movies) { $0.year }
        self.categoriesMovies = categoriesedMovieList
     
    }
    
    func categoriesSortedMovie() {
        let categoriesedMovieList  = Dictionary(grouping: filterMovies.sorted(by: {$0.year > $1.year })) { $0.year }
        
        
        self.categoriesMovies = categoriesedMovieList
        
    }
    
    func searchMovies(searchText: String) {
        if searchText.isEmpty {
            filterMovies = movies
            categoriesMovie()
        }
        else  {
            filterMovies =  movies.filter({$0.title.contains(searchText)})
            categoriesSortedMovie()
        }
 
        
    }
}


