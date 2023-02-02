//
//  CoordinatorApp.swift
//  Coordinator
//
//  Created by 김남수 on 2023/01/10.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

@main
struct TestCoordinatorApp: App {
    var body: some Scene {
        WindowGroup {
            MainCoordinator(baseView: MainView()).rootView
        }
    }
}

struct MainView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        VStack {
            Text("메인뷰")
            Button {
                coordinator.pushAView()
            } label: {
                Text("push A")
            }
        }
    }
}


struct AView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        VStack {
            Text("A 뷰")
            Button {
                coordinator.setupTitle("타이틀변경!!")
            } label: {
                Text("setup Navi")
            }
            Button {
                coordinator.navigationAttributeTitle(title: "댓글")
            } label: {
                Text("타이틀 폰트부분 적용")
            }
            Button {
                coordinator.popToRootView()
            } label: {
                Text("root")
            }
        }
    }
}
