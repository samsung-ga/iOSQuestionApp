//
//  AnswerTable.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

import SQLite

protocol AnswerTableProtocol {
    typealias AnswerList = [Answer]
    
    func createTable()
    func insertRow(_ answer: Answer) -> Bool?
    func updateRow(_ answer: Answer) -> Bool?
    func getRow() -> AnswerList?
}

class AnswerTable: AnswerTableProtocol {
    
    typealias QuestionList = [Question]
    
    let table = Table("Answer")
    let id = Expression<Int>("id")
    let questionID = Expression<Int>("questionID")
    let content = Expression<String>("content")
    let date = Expression<String>("date")
    
    /// table 생성여부를 확인하여 생성되었다면 아무 작동 X, 생성되지 않았다면 작동 O
    func createTable() {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return
        }
        
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(questionID)
                table.column(content)
                table.column(date)
            })
        } catch {
            fatalError()
        }
    }
    
    func insertRow(_ answer: Answer) -> Bool? {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return nil
        }
        
        do {
            // MARK: id 자동 생성
            try database.run(table.insert(questionID <- answer.questionID,
                                          content <- answer.content,
                                          date <- answer.date))
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    // MARK: 절대 쓰면 안 되는 메소드
    /// 절대 쓰면 안 되는 메소드
    func updateRow(_ answer: Answer) -> Bool? {
        return nil
    }
    
    func getRow() -> AnswerList? {
        guard let database = SQLiteDatabase.shared.database else {
            print(DatabaseError.databaseConnectionError.description)
            return nil
        }
        
        var answerArray = AnswerList()
        do {
            for answerTable in try database.prepare(table) {
                
                let id = answerTable[id]
                let questionID = answerTable[questionID]
                let content = answerTable[content]
                let date = answerTable[date]
                
                let answer = Answer(id: id, questionID: questionID, content: content, date: date)
                answerArray.append(answer)
            }
        } catch {
            return nil
        }
        
        return answerArray
    }
    
    
}
