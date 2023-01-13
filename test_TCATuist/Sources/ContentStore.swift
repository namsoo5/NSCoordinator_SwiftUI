//
//  ContentStore.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/10.
//  Copyright © 2023 ns. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct ContentStore: ReducerProtocol {
    struct State: Equatable {
        var num: Int = 0
    }
    
    enum Action: Equatable {
        case push
        case modal
        case random
    }
    @Dependency(\.contentUseCase) var useCase: ContentUseCase
    @Dependency(\.contentUseCaseStruct) var useCaseStruct: ContentUseCaseStruct
    @Dependency(\.contentUseCaseClass) var useCaseClass: ContentUseCaseClass
    
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .push:
            print("push")
        case .modal:
            print("modal")
        case .random:
            print("random")
            let num = useCase.request()
            let num2 = useCaseStruct.request()
            let num3 = useCaseClass.request()
            print(num, num2, num3)
        }
        
        return .none
    }
}

final class ContentUseCase {
    var id: Int
    init() {
        print("usecase", #function)
        id = 10
    }
    
    deinit {
        print("usecase", #function)
    }
    
    func request() -> Int {
        self.id += 5
        return id
    }
}

// DependencyKey 구조체
struct ContentUseCaseStruct: DependencyKey {
    var id: Int
    init() {
        print("usecaseStruct", #function)
        id = 10
    }
    
    func request() -> Int {
        return id
    }
    
    static var liveValue: ContentUseCaseStruct {
        ContentUseCaseStruct()
    }
}

// DependencyKey 클래스
class ContentUseCaseClass: DependencyKey {
    var id: Int
    init() {
        print("usecaseClass", #function)
        id = 10
    }
    
    deinit {
        print("usecaseClass", #function)
    }
    
    func request() -> Int {
        self.id += 5
        return id
    }
    
    static var liveValue: ContentUseCaseClass {
        ContentUseCaseClass()
    }
}

extension ContentUseCase: DependencyKey {
    static var liveValue: ContentUseCase { ContentUseCase() }
}

extension DependencyValues { // Value에등록해야 @Dependency 키패스로 뺴올수있음
    var contentUseCase: ContentUseCase { ContentUseCase() }
    var contentUseCaseStruct: ContentUseCaseStruct {
        get { self[ContentUseCaseStruct.self] } // Key에 등록되어야 배열 값으로 사용할 수 있음
        set { self[ContentUseCaseStruct.self] = newValue }
    }
    var contentUseCaseClass: ContentUseCaseClass {
        get { self[ContentUseCaseClass.self] }
        set { self[ContentUseCaseClass.self] = newValue }
    }
}
