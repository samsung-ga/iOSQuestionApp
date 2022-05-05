//
//  DatabaseError.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/03.
//

import Foundation

enum DatabaseError: Error {
    case databaseConnectionError
    
    var description: String {
        switch self {
        case .databaseConnectionError:
            return "데이터베이스와 연결이 실패했어요."
        }
    }
}
