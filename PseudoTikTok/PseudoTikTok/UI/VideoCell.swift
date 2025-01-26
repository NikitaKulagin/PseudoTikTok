//
//  VideoCell.swift
//  PseudoTikTok
//
//  Created by Никита Кулагин on 26.01.2025.
//

import UIKit

class VideoCell: UICollectionViewCell {

    // Представление для видео (в дальнейшем заменим на проигрыватель видео)
    let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black // Заглушка для представления видео
        return view
    }()

    // Подпись или описание видео
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()

    // Кнопка лайка
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("❤️ 0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func setupViews() {
        // Отключаем автоматическое создание ограничений
        videoView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем videoView на ячейку
        contentView.addSubview(videoView)

        // Закрепляем videoView на весь экран ячейки
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            videoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // Добавляем описание и кнопку лайка на videoView
        videoView.addSubview(descriptionLabel)
        videoView.addSubview(likeButton)

        // Добавляем ограничения для descriptionLabel и likeButton с учетом безопасных областей
        // Добавляем ограничения для descriptionLabel и likeButton
        NSLayoutConstraint.activate([
            // descriptionLabel
            descriptionLabel.leadingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: videoView.safeAreaLayoutGuide.bottomAnchor, constant: -100),

            // likeButton
            likeButton.trailingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: -16),
            likeButton.bottomAnchor.constraint(equalTo: videoView.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configure(with video: VideoModel) {
        // Настраиваем ячейку с данными видео
        descriptionLabel.text = video.description
        likeButton.setTitle("❤️ \(video.likesCount)", for: .normal)

        // Здесь можно добавить настройку проигрывателя видео с использованием video.videoURL
    }
}
