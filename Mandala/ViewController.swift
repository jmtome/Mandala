//
//  ViewController.swift
//  Mandala
//
//  Created by Juan Manuel Tome on 05/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    let visualBlur: UIVisualEffectView = {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .systemMaterialDark)
        let vb = UIVisualEffectView(effect: blurEffect)
        vb.translatesAutoresizingMaskIntoConstraints = false
        
        return vb
    }()
    let stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = .systemTeal
        sv.addArrangedSubview(view)
        sv.distribution = .fillEqually
        sv.spacing = 12
        
        return sv
    }()
    let moodButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle("MoodButton", for: .normal)
        button.backgroundColor = .systemPink
        return button
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(visualBlur)
        visualBlur.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        visualBlur.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        visualBlur.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //visualBlur.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //visualblur's height will depend upon its content
        
        visualBlur.contentView.addSubview(stackView)
        //visualBlur.addSubview(stackView)
        //you dont add subviews to visualblur but to its contentview
        stackView.leadingAnchor.constraint(equalTo: visualBlur.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: visualBlur.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: visualBlur.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: visualBlur.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        self.view.addSubview(moodButton)
        moodButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        moodButton.bottomAnchor.constraint(equalTo: visualBlur.topAnchor, constant: -20).isActive = true
        moodButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

