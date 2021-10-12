// Films.swift
// Copyright © RM. All rights reserved.

import Foundation
/// структура принимаемого джсона
struct Category: Decodable {
    var results: [ResultsFilm]
}

/// структура описания фильма из джсона
struct ResultsFilm: Decodable {
    var posterPath: String?
    var id: Int
    var overview: String
    var title: String
    var voteAverage: Float
}

/// структура описания фильма в запросе на определенный фильм
struct FilmDescription: Decodable {
    var title: String
    var posterPath: String?
    var overview: String
    var budget: Int?
    var originalTitle: String?
    var releaseDate: String?
}
