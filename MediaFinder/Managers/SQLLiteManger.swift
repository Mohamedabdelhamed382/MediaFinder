//
//  Sql Lite Mananger.swift
//  MediaFinder
//
//  Created by Mohamed Abdelhamed Ahmed on 1/3/21.
//  Copyright © 2021 Mohamed Abdelhamed Ahmed. All rights reserved.
//

import Foundation
import SQLite

class SqlLiteManger{
    //MARK:- Singleton Sutep
    private static let sharedInstans = SqlLiteManger()
    class func shared() -> SqlLiteManger {
        return SqlLiteManger.sharedInstans
    }
    //MARK:- Propreties
    var database: Connection!
    let userTable = Table("user")
    let SearchTabel = Table("searchTable")
    let userData = Expression<Data>("User")
    let lastSearch = Expression<Data>("Search")
}
//MARK:- Public Methods
extension SqlLiteManger{
    func setUpDatabase(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    func createTabelDataUser(){
        let createTable = self.userTable.create{(Table) in
            Table.column(self.userData)
        }
        do {
            try self.database.run(createTable)            
            print("Tabel ceated")
        }catch{
            print(error)
        }
    }
    func createTabelSearch (){
        let createTableSearch = self.SearchTabel.create{(Table) in
            Table.column(self.lastSearch)
            
        }
        do {
            try self.database.run(createTableSearch)
            print("Tabel ceated")
        }catch{
            print(error)
        }
    }
    func insertUser(userData: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userData) {
            let insertUserSearch = userTable.insert(self.userData <- encoded)
            do {
                try self.database.run(insertUserSearch)
                print("User  inserted")
            }catch{
                print(error)
            }
        }
    }
    func insertSearch(userSearch: [Media]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userSearch) {
            let insertSearch = SearchTabel.insert(self.lastSearch <- encoded)
            do {
                try self.database.run(insertSearch)
                print("Search  Data inserted")
            }catch{
                print(error)
            }
        }
    }
    func getDataUser( ) -> User?{
        do {
            let decoder = JSONDecoder()
            let printList =  try self.database.prepare(self.userTable)
            for user in printList {
                let userData = user[self.userData]
                if let loadedUser = try? decoder.decode(User.self, from: userData) {
                    return loadedUser
                }
            }
        }catch{
            print(error)
        }
        return nil
    }
    func getDataSearch( ) -> [Media]?{
        do {
            let decoder = JSONDecoder()
            let printList =  try self.database.prepare(self.SearchTabel)
            for user in printList {
                let userDataSearch = user[self.lastSearch]
                if let loadedUserSearch = try? decoder.decode([Media].self, from: userDataSearch ) {
                    return loadedUserSearch
                }
            }
        }catch{
            print(error)
        }
        return nil
    }
    func deleteLastSearch(){
        let search = self.SearchTabel
        let deleteSearch = search.delete()
        do{
            try self.database.run(deleteSearch)
        } catch{
            print(error)
        }
    }
}

