//
//  AnimeTableViewCell.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import UIKit

protocol AnimeTableViewCellDelegate: class {
    func didActionButtonTapped(in cell: AnimeTableViewCell)
}

class AnimeTableViewCell: BasedTableViewCell {
    weak var delegate: AnimeTableViewCellDelegate?
    
    var anime: Anime? {
        didSet {
            coverImageView.kf.setImage(with: anime?.imageURL?.imageResource)
            titleLabel.text = anime?.title
            rankLabel.text = "Rank \(anime?.rankText ?? "-")"
            typeLabel.text = ",Type: \(anime?.type ?? "-")"
            
            if anime?.start_date == nil && anime?.end_date == nil {
                durationLabel.text = "Upcoming"
            } else {
                durationLabel.text = "\(anime?.start_date ?? "-") - \(anime?.end_date ?? "Unkown")"
            }
            
            actionButton.setTitle((anime?.isFavorite ?? false) ? "Remove from favorite" : "Add to favorite", for: .normal)
            actionButton.setTitleColor((anime?.isFavorite ?? false) ? .systemRed : .systemBlue, for: .normal)
        }
    }
    
    lazy var coverImageView: LayoutImageView = {
        let imageView = LayoutImageView()
        imageView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
        return imageView
    }()
    lazy var titleLabel: LayoutLabel = {
        let label = LayoutLabel(textColor: .label, fontSize: 17.basedOnScreenWidth(), fontWeight: .medium)
        label.numberOfLines = 2
        return label
    }()
    lazy var rankLabel = LayoutLabel(textColor: .secondaryLabel, fontSize: 15.basedOnScreenWidth())
    lazy var typeLabel = LayoutLabel(textColor: .secondaryLabel, fontSize: 15.basedOnScreenWidth())
    lazy var durationLabel = LayoutLabel(textColor: .tertiaryLabel, fontSize: 14.basedOnScreenWidth())
    lazy var actionButton: LayoutButton = {
        let button = LayoutButton(title: "Add to favorite", target: self, action: #selector(onActionButtonTap), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: Object life cycle
    override func setUpAndLayoutViews() {
        super.setUpAndLayoutViews()
        
        contentView.addCenterYSubview(coverImageView)
        coverImageView.rectangled(width: 100.basedOnScreenWidth(), height: 153.7.basedOnScreenWidth())
        contentView.addSubview(titleLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.basedOnScreenWidth()),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 15.basedOnScreenWidth()),
            titleLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor, constant: 5.basedOnScreenWidth()),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.basedOnScreenWidth()),
            rankLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.basedOnScreenWidth()),
            typeLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8.basedOnScreenWidth()),
            typeLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            durationLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 6.basedOnScreenWidth()),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: -4.basedOnScreenWidth()),
            actionButton.heightAnchor.constraint(equalToConstant: 24.basedOnScreenWidth())
        ])
    }
    
    // MARK: User action
    @objc func onActionButtonTap() {
        delegate?.didActionButtonTapped(in: self)
    }
}
