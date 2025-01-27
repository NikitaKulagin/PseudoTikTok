//
//  VideoCell.swift
//  PseudoTikTok
//
//  Created by Никита Кулагин on 26.01.2025.
//

import UIKit
import AVFoundation

class VideoCell: UICollectionViewCell {
    // Проигрыватель видео
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    // Представление для видео (используется как контейнер для плеера)
    let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black // Фоновый цвет на случай, если видео не загрузится
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
        button.setTitle("❤ 0", for: .normal)
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
        likeButton.setTitle("❤ \(video.likesCount)", for: .normal)
        
        // Если плеер уже существует, останавливаем его и удаляем
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
        
        // Создаём URL из строки videoURL
        guard let url = URL(string: video.videoURL) else {
            print("Неверный URL видео")
            return
        }
        
        // Инициализируем AVPlayer и AVPlayerLayer
        player = AVPlayer(url: url)
        player?.isMuted = true // Отключаем звук, если необходимо
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = videoView.bounds
        
        // Добавляем playerLayer на videoView
        if let playerLayer = playerLayer {
            videoView.layer.insertSublayer(playerLayer, at: 0)
        }
        
        // Добавляем наблюдателя на окончание воспроизведения для повторного воспроизведения
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // Начинаем воспроизведение
        player?.play()
    }
    
    @objc func playerDidFinishPlaying(notification: Notification) {
        // Повторное воспроизведение видео
        player?.seek(to: .zero)
        player?.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Обновляем frame playerLayer при изменении размера ячейки
        playerLayer?.frame = videoView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Останавливаем и очищаем плеер перед повторным использованием ячейки
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        NotificationCenter.default.removeObserver(self)
    }
}
