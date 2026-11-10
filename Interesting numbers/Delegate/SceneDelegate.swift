//
//  SceneDelegate.swift
//  Interesting numbers
//
//  Created by Daniel Husiuk on 19.10.2026.
//

import UIKit
import InterestingNumbersLibrary

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let apiService: ApiServiceProtocol
        
#if DEBUG
        if ProcessInfo.processInfo.arguments.contains("-uiTesting") {
            apiService = MockService()
        } else {
            apiService = ApiService()
        }
#else
        apiService = ApiService()
#endif
        
        let mainViewController = ViewController(apiService: apiService)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.tintColor = .customPurple
        self.window = window
        window.makeKeyAndVisible()
    }
}
