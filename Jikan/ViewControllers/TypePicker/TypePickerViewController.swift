//
//  TypePickerViewController.swift
//  Jikan
//
//  Created by CHI on 2021/1/30.
//

import UIKit

protocol TypePickerViewControllerDelegate: class {
    func didAnimeTypePicked(type: Anime.MainType, subType: Anime.SubType?)
}

class TypePickerViewController: BasedViewController<BasedViewModel> {
    weak var delegate: TypePickerViewControllerDelegate?
    
    var selectedType: Anime.MainType {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var selectedSubType: Anime.SubType? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var cancelButton: LayoutButton = {
        let button = LayoutButton(title: "Cancel", target: self, action: #selector(onCancelButtonTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.basedOnScreenWidth())
        return button
    }()
    
    lazy var confirmButton: LayoutButton = {
        let button = LayoutButton(title: "Confirm", target: self, action: #selector(onConfirmButtonTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.basedOnScreenWidth())
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TypePickerCollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TypePickerCollectionViewCell.self, forCellWithReuseIdentifier: "TypePicker")
        collectionView.register(TypePickerCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TypePickerSectionHeader")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: Object life cycle
    init(selectedType: Anime.MainType, selectedSubType: Anime.SubType? = nil) {
        self.selectedType = selectedType
        self.selectedSubType = selectedSubType
        
        super.init(viewModel: BasedViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .tertiarySystemBackground
        
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        
        view.addSameWidthSubview(collectionView)
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5.basedOnScreenWidth()),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 44.basedOnScreenWidth()),
            cancelButton.widthAnchor.constraint(equalToConstant: 70.basedOnScreenWidth()),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5.basedOnScreenWidth()),
            confirmButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44.basedOnScreenWidth()),
            confirmButton.widthAnchor.constraint(equalToConstant: 70.basedOnScreenWidth()),
            collectionView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: User action
    @objc func onCancelButtonTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onConfirmButtonTap() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else {
                return
            }
            self.delegate?.didAnimeTypePicked(type: self.selectedType, subType: self.selectedSubType)
        }
    }
}

extension TypePickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return types.count
        case 1:
            return subtypes[selectedType]?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypePicker", for: indexPath) as! TypePickerCollectionViewCell
        switch indexPath.section {
        case 0:
            let type = types[indexPath.item]
            cell.text = type.text
            cell.isPicked = (selectedType == type)
        case 1:
            let subtype = subtypes[selectedType]?[indexPath.item]
            cell.text = subtype?.text
            cell.isPicked = (selectedSubType == subtype)
        default:
            break
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TypePickerSectionHeader", for: indexPath) as! TypePickerCollectionReusableView
        header.title = sectionHeaders[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedType = types[indexPath.item]
            selectedSubType = nil
        case 1:
            if selectedSubType == subtypes[selectedType]?[indexPath.item] {
                selectedSubType = nil
            } else {
                selectedSubType = subtypes[selectedType]?[indexPath.item]
            }
        default:
            break
        }
    }
}

extension TypePickerViewController {
    var sectionHeaders: [String] {
        return ["Type", "Subtype"]
    }
    
    var types: [Anime.MainType] {
        return [.anime, .manga]
    }
    
    var subtypes: [Anime.MainType: [Anime.SubType]] {
        return [
            .anime : [.airing, .upcoming, .tv, .movie, .ova, .special, .bypopularity, .favorite],
            .manga : [.manga, .novels, .oneshots, .doujin, .manhwa, .manhua , .bypopularity, .favorite]
        ]
    }
}
