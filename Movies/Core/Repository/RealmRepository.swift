// RealmRepository.swift
// Copyright © RM. All rights reserved.

import Foundation
import RealmSwift

protocol Repository {
    func save<T>(object: [T]) where T: Object
    func get<T>(type: T.Type) -> Results<T>? where T: Object
    func remove<T>(object: Results<T>) where T: Object
}

final class RealmRepository: Repository {
    private let deleteMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    func save<T>(object: [T]) where T: Object {
        do {
            let realm = try Realm(configuration: deleteMigration)
            print(realm.configuration.fileURL)
            realm.beginWrite()
//            realm.delete(object)
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }

    func remove<T>(object: Results<T>) where T: Object {
        do {
            let realm = try Realm(configuration: deleteMigration)
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func get<T>(type: T.Type) -> Results<T>? where T: Object {
        let realm = try? Realm(configuration: deleteMigration)
        guard let results = realm?.objects(type) else { return nil }
        return results
    }
}
