//
//  UICollectionView+Extension.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
import ESPullToRefresh

extension UICollectionView {
    func register(with cellIdentifier: CellIdentifier) {
        self.register(UINib(nibName: cellIdentifier.rawValue, bundle: nil), forCellWithReuseIdentifier: cellIdentifier.rawValue)
    }
    
    func setupEmptyView(delegate: EmptyViewDelegate?) {
        guard let emptyView = mainBundle.loadNibNamed("EmptyView", owner: self, options: nil)?.first as? EmptyView else { return }
        emptyView.delegate = delegate
        self.backgroundView = emptyView
        self.backgroundView?.isHidden = true
    }
    
    func setupPullToRefresh(action: @escaping () -> ()) {
        self.es.addPullToRefresh(handler: action)
    }
    
    func setupLoadMore(action: @escaping () -> ()) {
        self.es.addInfiniteScrolling(handler: action)
    }
    
    
    func showEmptyView(viewType: EmptyViewType) {
        guard let emptyView = backgroundView as? EmptyView else { return }
        emptyView.viewType  = viewType
        emptyView.viewSetup()
        emptyView.isHidden  = false
    }
    
    func hideEmptyView() {
        backgroundView?.isHidden = true
    }
    
    func validate(indexPath: IndexPath) -> Bool {
        if indexPath.section >= numberOfSections {
            return false
        }
        
        if indexPath.row >= numberOfItems(inSection: indexPath.section) {
            return false
        }
        
        return true
    }
}

extension UICollectionView {

    var isLastItemFullyVisible: Bool {

        let numberOfItems = self.numberOfItems(inSection: 0)
        let lastIndexPath = IndexPath(item: numberOfItems - 1, section: 0)

        guard let attrs = collectionViewLayout.layoutAttributesForItem(at: lastIndexPath)
        else {
            return false
        }
        return bounds.contains(attrs.frame)
    }

    // If you don't care if it's fully visible, as long as some of it is visible
    var isLastItemVisible: Bool {
       let numberOfItems = self.numberOfItems(inSection: 0)
       return indexPathsForVisibleItems.contains(where: { $0.item == numberOfItems - 1 })
    }
}
