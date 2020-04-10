//
//  Enviroment.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation

enum Environment {
    case prod
}

extension Environment {
    var contentBaseURl: String {
        switch self {
        case .prod:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
}
