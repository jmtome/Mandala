//
//  ViewController.swift
//  Mandala
//
//  Created by Juan Manuel Tome on 05/07/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    var moods: [Mood] = [Mood]() {
        didSet {
            currentMood = moods.first
//            moodButtons = moods.map { mood in
//                let moodButton = UIButton()
//                moodButton.setImage(mood.image, for: .normal)
//                moodButton.imageView?.contentMode = .scaleAspectFit
//                moodButton.adjustsImageWhenHighlighted = false
//                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
//                return moodButton
//
//            }
            
            moodSelector.images = moods.map { (mood) in
                return mood.image
            }
            
        }
    }
//    var moodButtons: [UIButton] = [UIButton]() {
//        didSet {
//            oldValue.forEach { (button) in
//                button.removeFromSuperview()
//            }
//            moodButtons.forEach { (button) in
//                stackView.addArrangedSubview(button)
//            }
//
//        }
//    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
            
        }
    }
    
    @objc private func moodSelectionChanged(_ sender: ImageSelector) {
        
        let selectedIndex = sender.selectedIndex
        
        currentMood = moods[selectedIndex]
        
    }
    
    let visualBlur: UIVisualEffectView = {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .regular)
        
        let vb = UIVisualEffectView(effect: blurEffect)
        vb.translatesAutoresizingMaskIntoConstraints = false
        return vb
    }()
    
    let addMoodButton: UIButton! = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle("MoodButton", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 4)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
        return button
    }()
    
    
    var moodSelector: ImageSelector! = {
        let selector = ImageSelector(frame: .zero)
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return selector
    }()
    
    
    var moodsConfigurable: MoodsConfigurable!
    
    override func loadView() {
        super.loadView()
        
        
        //embedded tableviewcontroller
        let embededController = storyboard!.instantiateViewController(identifier: "moodListVC")
        addChild(embededController)
        embededController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(embededController.view)
        
        NSLayoutConstraint.activate([
            embededController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            embededController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            embededController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            embededController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        embededController.didMove(toParent: self)
        
        //stuff below was inside prepare for segue had it been done with storyboard
        
        //“Here you verify that the destination view controller conforms to the MoodsConfigurable protocol and then store this destination in the moodsConfigurable property.”
        guard let moodsConfigurable = embededController as? MoodsConfigurable else {
            preconditionFailure("View controller expected to conform to Moods Configurable")
        }
        self.moodsConfigurable = moodsConfigurable
        //study what happens here, so we are actually assigning a viewcontroller that conforms to a protocol to a protocol, this should mean that the protocol object should have access to the methods of the casted VC that conformed to the protocol?
        //this is clearly a form of forward delegation, but its not directly called like that though,
        //TODO: - Research about this
        
        embededController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        //this above doesnt work i dont know what's it for
        //stuff above was inside prepare for segue had it been done with storyboard
        
        self.view.addSubview(visualBlur)
        visualBlur.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        visualBlur.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        visualBlur.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //visualBlur.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //visualblur's height will depend upon its content
        
        visualBlur.contentView.addSubview(moodSelector)
        //visualBlur.addSubview(stackView)
        //you dont add subviews to visualblur but to its contentview
        moodSelector.leadingAnchor.constraint(equalTo: visualBlur.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        moodSelector.trailingAnchor.constraint(equalTo: visualBlur.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        moodSelector.bottomAnchor.constraint(equalTo: visualBlur.contentView.layoutMarginsGuide.bottomAnchor, constant: 0).isActive = true
        moodSelector.topAnchor.constraint(equalTo: visualBlur.contentView.topAnchor, constant: 8).isActive = true
        moodSelector.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(addMoodButton)
        addMoodButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addMoodButton.bottomAnchor.constraint(equalTo: visualBlur.topAnchor, constant: -20).isActive = true
        addMoodButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        addMoodButton.addTarget(self, action: #selector(addMoodTapped(_:)), for: .touchUpInside)
        
    }
    @objc private func addMoodTapped(_ sender: UIButton) {
        guard let currentMood = currentMood else { return }
        
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
        //TODO: - Research about this

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        moods = [.happy,.sad,.angry,.goofy,.crying,.confused,.sleepy,.meh]
        
        
    }


}

