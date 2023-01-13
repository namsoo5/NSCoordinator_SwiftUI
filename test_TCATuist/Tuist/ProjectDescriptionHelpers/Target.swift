//
//  Target.swift
//  ProjectDescriptionHelpers
//
//  Created by 김남수 on 2023/01/10.
//

import Foundation
import ProjectDescription

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "Appearance": "Dark",
    "NSAppTransportSecurity": [
        "NSAllowsArbitraryLoads": true
    ]
]

// MARK: - Target

public let mainTarget = Target(
    name: "NSCoordinatorMain",
    platform: .iOS,
    product: .app,
    bundleId: "ns.coordinator",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .external(name: "ComposableArchitecture")
    ],
    settings: Settings.debugSettings
)
