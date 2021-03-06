//
//  AppDelegate.swift
//  space
//
//  Created by Kamila Kusainova on 26.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AppDelegate.shared = self
        return true
    }
    
    func presentGameViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Game")
        switchRoot(viewController: vc)
    }
    
    func presentHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home")
        switchRoot(viewController: vc)
    }
    
    func presentScoreViewController(beersSpawned: Int, beersDrank: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Score") as! ScoreViewController
        vc.beersSpawned = beersSpawned
        vc.score = beersDrank
        switchRoot(viewController: vc)
    }
    
    func presentLeaderBoardViewControler() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Leaderboard") as! LeaderboardPage
        switchRoot(viewController: vc)
    }
    
    private func switchRoot(viewController: UIViewController) {
        guard let window = window, window.rootViewController != viewController else { return }
        
        UIView.transition(with: window, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        }) { result in
            
        }
    }
}

