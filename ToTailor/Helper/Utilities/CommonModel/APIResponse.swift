//
//  APIResponse.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
struct APIResponse<T: Decodable> {
    let meta: Meta
    let data: T?
    let error: String?
}

extension APIResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta    = try   container.decode(Meta.self,     forKey: .meta)
        data    = try?  container.decode(T.self,        forKey: .data)
        error   = try?  container.decode(String.self,   forKey: .error)
    }
}
private enum CodingKeys: String, CodingKey {
    case meta
    case data
    case error
}
