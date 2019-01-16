import Foundation
import RealmSwift

class RealmHelper {

    let realm: Realm
    static let sharedInstance = RealmHelper()

    private init() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    func getObjects(type: Object.Type) -> Results<Object> {
        return realm.objects(type)
    }

    func add<T: Object>(_ item: T? = nil, items: [T]? = nil) {
        do {
            try realm.write {
                if let item = item {
                    realm.add(item)
                }
                if let items = items {
                    realm.add(items)
                }
            }
        } catch {
            print(" REALM ERROR: \(error)")
        }
    }

    func updateWithValues<T: Object>(_ item: T, with params: [String:Any]) {
        do {
            try realm.write {
                for (key, value) in params {
                    item.setValue(value, forKey: key)
                }
            }
        } catch {
            print(" REALM ERROR: \(error)")
        }
    }
    

    func executeTransaction(_ transaction: ()-> Void) {
        do {
            try realm.write {
                transaction()
            }
        } catch {
            print(" REALM ERROR: \(error)")
        }
    }

    func remove<T: Object>(_ item: T? = nil, items: [T]? = nil) {
        do {
            try realm.write {
                if let item = item {
                    realm.delete(item)
                }
                if let items = items {
                    realm.delete(items)
                }
            }
        } catch {
            print(" REALM ERROR: \(error)")
        }
    }
    func deleteAll() {
        do {
            try realm.write {
                let alreadySeen = realm.objects(MarvelCharacter.self)
                realm.delete(alreadySeen)
            }
        } catch {
            print(" REALM ERROR: \(error)")
        }
    }
}
