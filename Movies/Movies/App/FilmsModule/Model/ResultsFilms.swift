// ResultsFilms.swift
// Copyright © DmitrievSY. All rights reserved.

import Foundation
import RealmSwift
/// Model for movies
class Category: Decodable {
    var results: [ResultsFilm]
}

/// Model for movie properties
class ResultsFilm: Object, Decodable {
    @objc dynamic var posterPath: String?
    @objc dynamic var id: Int
    @objc dynamic var overview: String
    @objc dynamic var title: String
    @objc dynamic var voteAverage: Float

    override static func primaryKey() -> String? {
        "id"
    }
}
