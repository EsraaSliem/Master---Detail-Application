//
//  HomeDetailsViewController.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import UIKit
import SDWebImage
class HomeDetailsViewController: UIViewController {
   @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var movieTitle: UINavigationItem!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    var movie: Movie!
    var viewModel: HomeDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMVVM()
        initView()
        
        
    }
    @IBAction func onPressedBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initView() {
        yearLabel.text = "\(viewModel.movie.year)"
        castLabel.text = viewModel.cast
        genreLabel.text = viewModel.genres
        movieTitle.title = viewModel.movie.title
        configureCollectionView()
    }
    
    func initMVVM() {
        viewModel = HomeDetailsViewModel(movie: movie)
        viewModel.getMoviePhotos()
        viewModel.reloadMoviesCollectionsViewClosure = {
            self.moviesCollectionView.reloadData()
        }
    }
}

extension HomeDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
         moviesCollectionView.registerCellNib(cellClass: MovieViewCell.self)
         moviesCollectionView.delegate = self
         moviesCollectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return viewModel.getPhotsCount()
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeue(for: indexPath) as MovieViewCell
        cell.movieImage.sd_setImage(with: URL(string: viewModel.getPhotoINdex(index: indexPath.row)))
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - (2 + 1) * 8) / 2
        return CGSize(width: size, height:  size)
    }
}

