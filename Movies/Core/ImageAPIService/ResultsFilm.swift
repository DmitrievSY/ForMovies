// ResultsFilm.swift
// Copyright © RM. All rights reserved.

import Foundation
/// Model for movies
struct Category: Decodable {
    var results: [ResultsFilm]
}

/// Model for movie properties
struct ResultsFilm: Decodable {
    var posterPath: String?
    var id: Int
    var overview: String
    var title: String
    var voteAverage: Float
}
