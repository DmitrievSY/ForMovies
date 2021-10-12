// FilmDescription.swift
// Copyright © RM. All rights reserved.

import Foundation
/// Model for film description
struct FilmDescription: Decodable {
    var title: String
    var posterPath: String?
    var overview: String
    var budget: Int?
    var originalTitle: String?
    var releaseDate: String?
}
