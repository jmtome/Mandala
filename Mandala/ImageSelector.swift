//
//  ImageSelector.swift
//  Mandala
//
//  Created by Juan Manuel Tome on 05/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ImageSelector: UIControl {
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()
    
    private func configureViewHierarchy() {
        addSubview(selectorStackView)
        insertSubview(highlightView, belowSubview: selectorStackView)
        
        
        selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        selectorStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor).isActive = true
        highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor).isActive = true
        
    }
    
    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewHierarchy()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2
    }
    
    var selectedIndex = 0 {
        didSet {
            if selectedIndex < 0 {
                selectedIndex = 0
            }
            if selectedIndex >= imageButtons.count {
                selectedIndex = imageButtons.count - 1
            }
            let imageButton = imageButtons[selectedIndex]
            highlightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
            
        }
    }

    private let highlightView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = view.tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var imageButtons: [UIButton] = [UIButton]() {
        didSet {
            oldValue.forEach { (button) in
                button.removeFromSuperview()
            }
            imageButtons.forEach { (button) in
                selectorStackView.addArrangedSubview(button)
            }
            
        }
    }
    var images: [UIImage] = [UIImage]() {
        didSet {
            imageButtons = images.map { (image) in
                let imageButton = UIButton()
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
                return imageButton
            }
            selectedIndex = 0
            
        }
    }
    
    @objc private func imageButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("The buttons and images are not parallel")
        }
        selectedIndex = buttonIndex
        sendActions(for: .valueChanged)
        
    
    
    }
    
}
