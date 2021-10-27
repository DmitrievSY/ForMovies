// RealmRepository.swift
// Copyright © DmitrievSY. All rights reserved.

import Foundation
import RealmSwift

protocol Repository {
    func save<T>(object: [T]) where T: Object
    func get<T>(type: T.Type, column: String?, filmNumber: Int?) -> Results<T>? where T: Object
}

final class RealmRepository: Repository {
    private let deleteMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    func save<T>(object: [T]) where T: Object {
        do {
            let realm = try Realm(configuration: deleteMigration)
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func get<T>(type: T.Type, column: String? = nil, filmNumber: Int? = nil) -> Results<T>? where T: Object {
        if column != nil {
            guard let column = column,
                  let filmNumber = filmNumber else { return nil }
            let predicate = NSPredicate(format: "\(column) == %@", String(filmNumber))
            let realm = try? Realm()
            let filmDescriptionRealm = realm?.objects(type).filter(predicate)
            return filmDescriptionRealm
        } else {
            let realm = try? Realm(configuration: deleteMigration)
            guard let results = realm?.objects(type) else { return nil }
            return results
        }
    }
}
