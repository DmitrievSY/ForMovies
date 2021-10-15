// FilmDescription.swift
// Copyright © RM. All rights reserved.

import Foundation
import RealmSwift
/// Model for film description
class FilmDescription: Object, Decodable {
    @objc dynamic var title: String
    @objc dynamic var posterPath: String?
    @objc dynamic var overview: String
    @objc dynamic var budget: Int
    @objc dynamic var originalTitle: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var filmNumber: String?

    override static func primaryKey() -> String? {
        "filmNumber"
    }
}
