//
//  ViewModel.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation

class Model: NSObject, ViewModelable {
    
    typealias ReturnType = ViewModel
    var viewModel: ReturnType {
        fatalError("Must override")
    }

}

class ViewModel: NSObject {
}

protocol ViewModelable {
    associatedtype ReturnType: ViewModel
    var viewModel: ReturnType { get }
//    static func viewModels(from models: [Model]) -> [ReturnType]
}
