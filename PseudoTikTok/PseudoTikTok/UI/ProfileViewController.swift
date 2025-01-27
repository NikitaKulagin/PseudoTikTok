//
//  ProfileViewController.swift
//  PseudoTikTok
//
//  Created by Никита Кулагин on 26.01.2025.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {

    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        loadUserData()
    }

    func setupViews() {
        // Настройка profileImageView
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "placeholder") // Плейсхолдер
        view.addSubview(profileImageView)

        // Настройка usernameLabel
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        usernameLabel.text = "Загрузка..." // Текст по умолчанию
        view.addSubview(usernameLabel)

        // Настройка logoutButton
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        view.addSubview(logoutButton)

        // Установить ограничения (constraints)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logoutButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func loadUserData() {
        // Инициализируем Firestore
        let db = Firestore.firestore()

        // Получаем userID текущего пользователя
        // Если вы не используете аутентификацию, выставьте userID вручную
        let userID = "oHv1fU9p8vehzqGqadI8gdF0dtz1" // Замените на ваш userID

        // Получаем документ пользователя из коллекции "users"
        db.collection("users").document(userID).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Ошибка при загрузке данных пользователя: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.usernameLabel.text = "Ошибка загрузки"
                }
            } else if let document = document, document.exists {
                let data = document.data()
                let username = data?["username"] as? String ?? "Без имени"
                let profilePictureURL = data?["profilePictureURL"] as? String

                DispatchQueue.main.async {
                    self?.usernameLabel.text = username
                    if let urlString = profilePictureURL, let url = URL(string: urlString) {
                        self?.profileImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                    } else {
                        self?.profileImageView.image = UIImage(named: "placeholder")
                    }
                }
            } else {
                print("Документ пользователя не существует или нет прав доступа")
                DispatchQueue.main.async {
                    self?.usernameLabel.text = "Пользователь не найден"
                }
            }
        }
    }

    @objc func logoutTapped() {
        // Реализуйте логику выхода из аккаунта
    }
}
