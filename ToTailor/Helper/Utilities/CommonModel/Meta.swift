//
//  Meta.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation

struct Meta {
    let code: Int
    let message: String
}

extension Meta: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code       = (try? container.decode(Int.self, forKey: .code))          ?? 0
        message    = (try? container.decode(String.self, forKey: .message))    ?? String.empty
    }
}

private enum CodingKeys: String, CodingKey {
    case code
    case message
}
