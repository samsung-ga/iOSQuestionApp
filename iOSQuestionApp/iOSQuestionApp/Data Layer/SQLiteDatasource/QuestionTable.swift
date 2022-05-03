//
//  QuestionDatabase.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

import SQLite

protocol QuestionTableCommandsProtocol {
    typealias QuestionList = [Question]

    func createTable() -> Bool?
    func insertRow(_ question: Question) -> Bool?
    func updateRow(_ question: Question) -> Bool?
    func getRow() -> QuestionList?
}

class QuestionTable: QuestionTableCommandsProtocol {
  
    typealias QuestionList = [Question]

    let table = Table("Question")
    let id = Expression<Int>("id")
    let content = Expression<String>("content")
    let isAnswered = Expression<Bool>("isAnswered")
    
    func createTable() -> Bool? {
        guard let database = SQLiteDatabase.shared.database else {
            return false
        }
        
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(content)
                table.column(isAnswered)
            })
            return true
        } catch {
            return false
        }
    }
    
    func getRow() -> QuestionList? {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return nil
        }
        
        var questionArray = QuestionList()
        do {
            for questionTable in try database.prepare(table) {
                
                let id = questionTable[id]
                let content = questionTable[content]
                let isAnswered = questionTable[isAnswered]
                
                let question = Question(id: id, content: content, isAnswered: isAnswered)
                questionArray.append(question)
            }
        } catch {
            return nil
        }
        
        return questionArray
    }
    
    func insertRow(_ question: Question) -> Bool? {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return nil
        }
        
        do {
            try database.run(table.insert(id <- question.id,
                                          content <- question.content,
                                          isAnswered <- question.isAnswered))
            return true
        } catch let error {
            // TODO: primary key 가 중복되서 나는 오류 따로 처리해주기
            print(error)
            return false
        }
    }
    
    func updateRow(_ question: Question) -> Bool? {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return nil
        }
        
        let questionTarget = table.filter(id == question.id).limit(1)
        
        do {
            if try database.run(questionTarget.update(content <- question.content)) > 0 {
                print("update success")
                return true
            } else {
                return false
            }
        } catch let error {
            // TODO: 해당 row가 없는 경우의 에러도 처리해주기
            print(error)
            return false
        }
        
    }
}
