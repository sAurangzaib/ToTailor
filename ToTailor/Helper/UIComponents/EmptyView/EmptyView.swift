//
//  EmptyView.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import UIKit

protocol EmptyViewDelegate: class {
    func emptyViewButtonTapped()
}

class EmptyView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tragetButton: UIButton!
    
    weak var delegate: EmptyViewDelegate?
    var viewType: EmptyViewType = EmptyViewType.error {
        didSet {
            viewSetup()
        }
    }
}

extension EmptyView {
    @IBAction func actionButtonTapped() {
        delegate?.emptyViewButtonTapped()
    }
    
    func viewSetup() {
        imageView.image = viewType.image
        messageLabel.text = viewType.message
    }
}
