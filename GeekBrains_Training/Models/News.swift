//
//  News.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 09.05.2022.
//

import Foundation

struct Articles: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct News: Codable {
    var totalResults: Int = Int()
    let articles: [Articles]
}
