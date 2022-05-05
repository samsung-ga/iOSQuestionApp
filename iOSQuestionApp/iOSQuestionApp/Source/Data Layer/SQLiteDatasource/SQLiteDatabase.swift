//
//  SQLiteDatabase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

import SQLite

class SQLiteDatabase {
    static let shared = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: true)
            
            let fileURL = documentDirectory
                .appendingPathExtension("iOSQuestion")
                .appendingPathExtension("sqlite")

            database = try Connection(fileURL.path)
        } catch  {
            print(DatabaseError.databaseConnectionError.description)
        }
    }
}
