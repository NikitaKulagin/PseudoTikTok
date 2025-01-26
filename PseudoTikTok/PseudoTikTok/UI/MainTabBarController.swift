//
//  MainTabBarController.swift
//  PseudoTikTok
//
//  Created by Никита Кулагин on 25.01.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем экземпляры контроллеров
        let homeViewController = HomeViewController()
        let profileViewController = ProfileViewController()

        // Настраиваем заголовки и изображения вкладок
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)

        // Добавляем контроллеры в TabBarController
        self.viewControllers = [homeViewController, profileViewController]
    }
}
