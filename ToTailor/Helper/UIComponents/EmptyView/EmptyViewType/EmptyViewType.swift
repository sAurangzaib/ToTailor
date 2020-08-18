//
//  EmptyViewType.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import UIKit

enum EmptyViewType:Int {
    case error
    case noResults
    case offline
    
    var message: String {
        switch self {
        case .error:
            return "Unable to retrieve data, please try later."
        case .noResults:
            return "No results found."
        case .offline:
            return "You are offline."
        }
    }
    
    var image: UIImage {
        switch self {
        case .error:
            return #imageLiteral(resourceName: "icon_pull_to_refresh_arrow@2x.png")
        case .noResults:
            return #imageLiteral(resourceName: "Restaurant1")
        case .offline:
            return #imageLiteral(resourceName: "Restaurant1")
        }
    }
}

class EmptyTypeViewModel: ViewModel {
    var emptyViewType: EmptyViewType
    
    init(type: EmptyViewType) {
        emptyViewType = type
    }
}
