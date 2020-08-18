//
//  AppError.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
struct AppError {
    private var description: String
    var localizedDescription: String {
        return description
    }
    var code: Int
    
    init(description: String, code: Int = -1) {
        self.description = description
        self.code = code
    }
}
