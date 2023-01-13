//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 김남수 on 2023/01/10.
//

import Foundation
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            requirement: .upToNextMajor(from: "0.49.1")
        ),
    ],
    platforms: [.iOS]
)
