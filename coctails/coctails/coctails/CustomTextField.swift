////
////  CustomTextField.swift
////  coctails
////
////  Created by AnnaEvgen on 11.06.2022.
////
//
//import UIKit
//
//class CustomTextField: UITextField {
//    
//    var textField : UITextField = {
//      let tf = UITextField()
//        tf.placeholder = "Enter coctail name"
//        tf.font = .systemFont(ofSize: 20)
//        tf.backgroundColor = .systemBackground
//        tf.textAlignment = .center
//        tf.layer.cornerRadius = 8
//        tf.layer.shadowColor = UIColor.lightGray.cgColor
//        tf.layer.shadowOffset = CGSize(width: 1, height: 2)
//        tf.layer.shadowOpacity = 2
//        tf.layer.shadowRadius = 8
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//        
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setTextField()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setTextField()
//    }
//    
//    func setTextField() {
//        addSubview(textField)
//
//        textField.topAnchor.constraint(equalTo: topAnchor, constant:  8).isActive = true
//        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
//        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
//        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        
//    }
//}
