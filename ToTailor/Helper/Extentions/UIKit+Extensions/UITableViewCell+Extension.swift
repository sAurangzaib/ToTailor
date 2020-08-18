//
//  UITableViewCell+Extension.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
import ESPullToRefresh

extension UITableView {
    
    func register(with cellIdentifier: CellIdentifier) {
        self.register(UINib(nibName: cellIdentifier.rawValue, bundle: nil), forCellReuseIdentifier: cellIdentifier.rawValue)
    }
    
    func registerSection(with cellIdentifier: CellIdentifier) {
        self.register(UINib(nibName: cellIdentifier.rawValue, bundle: nil), forHeaderFooterViewReuseIdentifier: cellIdentifier.rawValue)
    }
    
    func setupEmptyView(delegate: EmptyViewDelegate?) {
        guard let emptyView = mainBundle.loadNibNamed("EmptyView", owner: self, options: nil)?.first as? EmptyView else { return }
        self.backgroundView = emptyView
        emptyView.delegate = delegate
        self.backgroundView?.isHidden = true
    }
    
    func setupPullToRefresh(action: @escaping () -> ()) {
        self.es.addPullToRefresh(handler: action)
    }
    
    func setupLoadMore(action: @escaping () -> ()) {
        self.es.addPullToRefresh(handler: action)
    }
    
    func showEmptyView(viewType: EmptyViewType) {
        guard let emptyView = backgroundView as? EmptyView else { return }
        emptyView.viewType  = viewType
        emptyView.viewSetup()
        self.bringSubviewToFront(emptyView)
        emptyView.isHidden  = false
    }
    
    func hideEmptyView() {
        backgroundView?.isHidden = true
    }
    
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        if lastRowIndex >= 0 {
            self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
        }
    }
}
