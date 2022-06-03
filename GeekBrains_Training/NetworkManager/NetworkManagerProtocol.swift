//
//  NetworkManagerProtocol.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 10.05.2022.
//

import Foundation


protocol NetworkManagerProtocol {
    func news(completion: @escaping (News) -> ())
}
