//
//  AppDelegate.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let questions: [Question] = [
            Question(id: 0, content: "Bounds 와 Frame 의 차이점을 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "ViewController의 생명주기를 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "UIKit 클래스들을 다룰 때 꼭 처리해야하는 애플리케이션 쓰레드 이름은 무엇인가?", isAnswered: false, category: .iOS),
            Question(id: 0, content: "Global DispatchQueue 의 Qos 에는 어떤 종류가 있는지, 각각 어떤 의미인지 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "hugging, resistance에 대해서 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "struct와 class와 enum의 차이를 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "Convenience init에 대해 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "Singleton 패턴을 활용하는 경우를 예를 들어 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "Hashable이 무엇이고, Equatable을 왜 상속해야 하는지 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "defer란 무엇인지 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "Generic에 대해 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "some 키워드에 대해 설명하시오.", isAnswered: false, category: .Swift),
            Question(id: 0, content: "Strong 과 Weak 참조 방식에 대해 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "ARC란 무엇인지 설명하시오.", isAnswered: false, category: .iOS),
            Question(id: 0, content: "함수형 프로그래밍이 무엇인지 설명하시오.", isAnswered: false, category: .Programming),
            Question(id: 0, content: "함수형 프로그래밍이 무엇인지 설명하시오.", isAnswered: false, category: .Programming),
            Question(id: 0, content: "Swift Standard Library의 map, filter, reduce, compactMap, flatMap에 대하여 설명하시오.", isAnswered: false, category: .Programming),
            Question(id: 0, content: "MVVM, MVI, Ribs, VIP 등 자신이 알고있는 아키텍쳐를 설명하시오.", isAnswered: false, category: .Architecture),
            Question(id: 0, content: "@State에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
            Question(id: 0, content: "@Binding에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
            Question(id: 0, content: "ObservedObject와 StateObject의 차이점에 대해 설명하시오.", isAnswered: false, category: .SwiftUI),
            Question(id: 0, content: "@Published에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
            Question(id: 0, content: "@Binding에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
            Question(id: 0, content: "Synchronous 방식과 Asynchronous 방식으로 URL Connection을 처리할 경우의 장단점을 비교하시오.", isAnswered: false, category: .Advanced),
            Question(id: 0, content: "Core Data와 Sqlite 같은 데이터 베이스의 차이점을 설명하시오.", isAnswered: false, category: .Advanced),
            Question(id: 0, content: "Run Loops에 대해 설명하시오.", isAnswered: false, category: .Advanced),
        ]

        let questionRepository = QuestionRepository()
        questionRepository.insertQuestions(questions)

//        let answerRepository = AnswerRepository()
//        print(answerRepository.getAnswerCount())
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


// MARK: 초기화 코드
/*
 
         let questions: [Question] = [
             Question(id: 0, content: "Bounds 와 Frame 의 차이점을 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "ViewController의 생명주기를 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "UIKit 클래스들을 다룰 때 꼭 처리해야하는 애플리케이션 쓰레드 이름은 무엇인가?", isAnswered: false, category: .iOS),
             Question(id: 0, content: "Global DispatchQueue 의 Qos 에는 어떤 종류가 있는지, 각각 어떤 의미인지 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "hugging, resistance에 대해서 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "struct와 class와 enum의 차이를 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "Convenience init에 대해 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "Singleton 패턴을 활용하는 경우를 예를 들어 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "Hashable이 무엇이고, Equatable을 왜 상속해야 하는지 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "defer란 무엇인지 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "Generic에 대해 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "some 키워드에 대해 설명하시오.", isAnswered: false, category: .Swift),
             Question(id: 0, content: "Strong 과 Weak 참조 방식에 대해 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "ARC란 무엇인지 설명하시오.", isAnswered: false, category: .iOS),
             Question(id: 0, content: "함수형 프로그래밍이 무엇인지 설명하시오.", isAnswered: false, category: .Programming),
             Question(id: 0, content: "함수형 프로그래밍이 무엇인지 설명하시오.", isAnswered: false, category: .Programming),
             Question(id: 0, content: "Swift Standard Library의 map, filter, reduce, compactMap, flatMap에 대하여 설명하시오.", isAnswered: false, category: .Programming),
             Question(id: 0, content: "MVVM, MVI, Ribs, VIP 등 자신이 알고있는 아키텍쳐를 설명하시오.", isAnswered: false, category: .Architecture),
             Question(id: 0, content: "@State에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
             Question(id: 0, content: "@Binding에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
             Question(id: 0, content: "ObservedObject와 StateObject의 차이점에 대해 설명하시오.", isAnswered: false, category: .SwiftUI),
             Question(id: 0, content: "@Published에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
             Question(id: 0, content: "@Binding에 대해서 설명하시오.", isAnswered: false, category: .SwiftUI),
             Question(id: 0, content: "Synchronous 방식과 Asynchronous 방식으로 URL Connection을 처리할 경우의 장단점을 비교하시오.", isAnswered: false, category: .Advanced),
             Question(id: 0, content: "Core Data와 Sqlite 같은 데이터 베이스의 차이점을 설명하시오.", isAnswered: false, category: .Advanced),
             Question(id: 0, content: "Run Loops에 대해 설명하시오.", isAnswered: false, category: .Advanced),
         ]
 
         let questionRepository = QuestionRepository()
         questionRepository.insertQuestions(questions)
 */
