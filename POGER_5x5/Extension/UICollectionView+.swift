//
//  UICollectionView+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/03.
//

import UIKit

extension UICollectionView {
    func isFirstCell(_ indexPath: IndexPath) -> Bool {
        return indexPath.item == 0
    }
    
    func isLastCell(_ indexPath: IndexPath) -> Bool {
        return indexPath.item == self.numberOfItems(inSection: indexPath.section) - 1
    }
}
