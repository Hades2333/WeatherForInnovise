//
//  MainViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit

class MainTabBar: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    //MARK: - Methods
    func setupVCs() {
        let todayVC = TodayViewController()
        todayVC.tabBarItem = UITabBarItem(title: "Today",
                                          image: UIImage(systemName: "sun.max"),
                                          selectedImage: UIImage(systemName: "sun.max.fill"))
        let forecastVC = ForecastViewController()
        forecastVC.tabBarItem = UITabBarItem(title: "Forecast",
                                             image: UIImage(systemName: "cloud.moon.bolt"),
                                             selectedImage: UIImage(systemName: "cloud.moon.bolt.fill"))

        viewControllers = [todayVC, forecastVC]
    }

}
