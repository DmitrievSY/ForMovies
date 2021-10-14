// Repository.swift
// Copyright © RM. All rights reserved.

protocol RepositoryProtocol {
    // var dataBase: DataBaseProtocol? { get set }
    func save<T: Object>(object: [T])
    func get()
}

import Foundation
import RealmSwift

final class RepositoryAll: RepositoryProtocol {
    // var dataBase: DataBaseProtocol?

    func save<T: Object>(object: [T]) {
        // dataBase?.save(object: object)
    }

    func get() {}
}
