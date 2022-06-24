//
//  CustomCell.swift
//  coctails
//
//  Created by AnnaEvgen on 08.06.2022.
//

import Foundation
import UIKit

class CustomItemCell: UICollectionViewCell {
   
    let bg = GradientView()
    
    override var isSelected: Bool {
           didSet {
               if isSelected { backgroundView = bg
               }  else {
                   backgroundView = nil
           }
       }
    }
    
    static let id = "cell"
    
    var label: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14)
        title.textAlignment = .center
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
