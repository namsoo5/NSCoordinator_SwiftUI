//
//  CoordinatorApp.swift
//  Coordinator
//
//  Created by 김남수 on 2023/01/10.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct TestTCATuistApp: App {
//    @StateObject private var coordinator = MainCoordinator(baseView: MainView())
    @StateObject private var tabCoordinator = TabCoordinator(
//        tabBase: [
//            NSTabBase(
//                coordinator: MainCoordinator(baseView: AView()),
//                title: "A뷰",
//                image: .add,
//                selectedImage: nil
//            ),
//            NSTabBase(
//                coordinator: MainCoordinator(baseView: MainView()),
//                title: "B뷰",
//                image: .checkmark,
//                selectedImage: UIImage(systemName: "heart")
//            ),
//            NSTabBase(
//                coordinator: MainCoordinator(baseView: CView()),
//                title: "C뷰",
//                image: UIImage(systemName: "heart"),
//                selectedImage: nil
//            )
//        ]
    )
    
    var body: some Scene {
        WindowGroup {
//            ContentView(
//                store: Store(
//                    initialState: ContentStore.State(),
//                    reducer: ContentStore()._printChanges()
//                )
//            )
//            coordinator.rootView
            tabCoordinator.rootView
        }
    }
}

struct MainView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    
    var body: some View {
        VStack {
            Button {
                print("A로 이동")
                coordinator.aView()
            } label: {
                Text("A 이동")
            }
            Button {
                print("B로 이동")
                coordinator.bView()
            } label: {
                Text("B 이동")
            }
            Button {
                coordinator.cView()
                print("C로 이동")
            } label: {
                Text("C 이동")
            }
            Button {
                coordinator.moveParentView()
                print("부모 컨트롤")
            } label: {
                Text("부모 컨트롤")
            }
            Button {
                coordinator.setViews([Color.gray, Color.black])
                print("set views")
            } label: {
                Text("set views")
            }
            Button {
                coordinator.popToRootView()
                print("pop root")
            } label: {
                Text("pop root")
            }
        }
    }
}

struct AView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @EnvironmentObject var tabCoordinator: TabCoordinator
    
    var body: some View {
        VStack {
            Color.red
            Button {
                print("A로 이동")
                coordinator.aView()
            } label: {
                Text("A 이동")
            }
            Button {
                coordinator.popToRootView()
                print("pop root")
            } label: {
                Text("pop root")
            }
            Button {
                tabCoordinator.moveThirdTab()
                print("탭전환")
            } label: {
                Text("3탭이동")
            }
            Button {
                tabCoordinator.secondTabNavigationTo(view: CView())
                print("다른탭 컨트롤")
            } label: {
                Text("다른탭 컨트롤")
            }
        }
    }
}

struct BView: View {
    var body: some View {
        Color.orange
    }
}

struct CView: View {
    var body: some View {
        Color.blue
    }
}
