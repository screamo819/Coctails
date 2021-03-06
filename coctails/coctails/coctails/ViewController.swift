//
//  ViewController.swift
//  coctails
//
//  Created by AnnaEvgen on 07.06.2022.
//

import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
    
    var networkData = NetworkDataFromJSON()
    var drinks = [Drink]()
    var filteredDrinks = [Drink]()
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 32, right: 8)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomItemCell.self, forCellWithReuseIdentifier: CustomItemCell.id)
        return cv
    }()
    
    let textFieldView: UITextField = {
        let tf = UITextField()
          tf.placeholder = "Enter coctail name"
          tf.font = .systemFont(ofSize: 20)
          tf.backgroundColor = .systemBackground
          tf.textAlignment = .center
          tf.layer.cornerRadius = 8
          tf.layer.shadowColor = UIColor.lightGray.cgColor
          tf.layer.shadowOffset = CGSize(width: 1, height: 2)
          tf.layer.shadowOpacity = 2
          tf.layer.shadowRadius = 8
          tf.translatesAutoresizingMaskIntoConstraints = false
          return tf
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(textFieldView)
        
        collectionView.dataSource = self
        collectionView.dataSource = self
        
        textFieldView.addTarget(self, action: #selector(searchCoctail(_ :)), for: .editingChanged)
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .systemBackground
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        textFieldView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        textFieldView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        textFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        networkData.getData(urlString: urlString) { [unowned self] (searchResponse) in
            switch searchResponse {
            case let .success(drinks):
                self.drinks = drinks
                self.filteredDrinks = drinks
                self.collectionView.reloadData()
            case .failure:
                print("Error")
            }
        }
    }
    
    @objc func searchCoctail(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            filteredDrinks = drinks
        } else {
            filteredDrinks = drinks.filter { $0.strDrink.contains(textField.text ?? "") }
        }
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomItemCell.id, for: indexPath) as! CustomItemCell
        cell.label.text = filteredDrinks[indexPath.row].strDrink
        
        cell.label.textColor = .white
        cell.layer.masksToBounds = true
        cell.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cell.layer.cornerRadius = cell.frame.size.height / 4
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomItemCell.id, for: indexPath)
        
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.textColor = .white
        let size = label.frame.size
        return CGSize(width: size.width + 20, height: 40)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
