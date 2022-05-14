//
//  CollectionView+Extension.swift
//  Moom
//
//  Created by Esraa Sliem on 22/02/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
  
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
           let identifier = String(describing: T.self)
          return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
      }
        
}
