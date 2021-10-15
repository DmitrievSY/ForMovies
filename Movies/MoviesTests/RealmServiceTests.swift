// RealmServiceTests.swift
// Copyright © RM. All rights reserved.

@testable import Movies
import RealmSwift
import XCTest

final class MockModel: Object {
    @objc dynamic var firtsValue = "Baz"
    @objc dynamic var surname = "Bar"

    override static func primaryKey() -> String? {
        "surname"
    }
}

/// realm tests
class RealmServiceTests: XCTestCase {
    var realmService: RealmRepository!

    override func setUpWithError() throws {
        realmService = RealmRepository()
    }

    override func tearDownWithError() throws {}

    func deleteMockDB() {
        let realm = try? Realm()
        do {
            try realm?.write {
                if let result = realm?.objects(MockModel.self) { realm?.delete(result) }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func testRealm() {
        let mockModel = MockModel()
        var mockObjects: [MockModel] = []
        mockObjects.append(mockModel)
        realmService.save(object: mockObjects)
        let objectsFromRealm = realmService.get(type: MockModel.self)

        XCTAssertNotNil(objectsFromRealm)
        deleteMockDB()
    }
}
