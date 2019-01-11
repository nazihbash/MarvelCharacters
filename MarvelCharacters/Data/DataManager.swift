////
////  DataManager.swift
////  MarvelCharacters
////
////  Created by Nazih on 1/11/19.
////  Copyright © 2019 Nazih Bash. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//import ReactiveSwift
//import ObjectMapper
//
//class DataManager {
//
//    public static let shared : DataManager = DataManager()
//
//    private init() {}
//
//    func initialize() {
//        var time = Date().timeIntervalSince1970
//        let characters  = RealmHelper.shared.getObjects(type: MarvelCharacter.self)
//
//        if characters.count > 0 {
//            time = Date().timeIntervalSince1970 - time
//            print("\n\n \(characters.count) characters fetched from realm in \(time) seconds \n\n")
//            self.updateCharacters()
//        }
//    }
//
//    func updateStores() {
//        NetworkServiceManager.sharedInstance.loadStores().startWithResult { (result) in
//            if let response = result.value, response.storesList.count > 0 {
//                var time = Date().timeIntervalSince1970
//
//                let serverStores = response.storesList
//                let serverStoreIds = serverStores.map({ return $0.number})
//
//                DispatchQueue.main.async {
//                    let realm = RealmHelper.shared.realm
//                    let locaStores = Array(realm.objects(Store.self).filter("number IN %@", serverStoreIds)
//                        .sorted(byKeyPath: "number", ascending: true))
//                    var storesDict: [String: Store] = [:]
//                    for store in locaStores {
//                        storesDict[store.number] = store
//                    }
//
//                    var storesToRemove: [Store] = [], storesToInsert: [Store] = [],
//                    storesToUpdate: [(local: Store, updated: Store)] = []
//
//                    for store in serverStores {
//                        let delta = store.delta.uppercased()
//                        if delta == "D" {
//                            if let localStore = storesDict[store.number] {
//                                storesToRemove.append(localStore)
//                            }
//                        } else if delta == "I" {
//                            storesToInsert.append(store)
//                        } else if delta == "U" {
//                            if let localStore: Store = storesDict[store.number] {
//                                storesToUpdate.append((local: localStore, updated: store))
//                            } else {
//                                storesToInsert.append(store)
//                            }
//                        }
//                    }
//
//
//                    RealmHelper.shared.remove(items: storesToRemove)
//                    RealmHelper.shared.add(items: storesToInsert)
//                    RealmHelper.shared.executeTransaction {
//                        for (initial, updated) in storesToUpdate {
//                            initial.update(source: updated)
//                        }
//                    }
//
//                    time = Date().timeIntervalSince1970 - time
//
//                    print("storesToInsert: \(storesToInsert.count), storesToRemove:\(storesToRemove.count), storesToUpdate:\(storesToUpdate.count), locaStores:\(locaStores.count), serverStores:\(serverStores.count)")
//                    print("store delta time:\(time)")
//
//                }
//            }
//        }
//    }
//}
