//
//  ViewController.swift
//  ContainerView1
//
//  Created by Tianbo Qiu on 12/27/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    
    var moods: [Mood] = [] {
        didSet {
            moodButtons = moods.map({ mood in
                let button = UIButton()
                button.setImage(mood.image, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
                return button
            })
        }
    }
    
    var moodButtons: [UIButton] = [] {
        didSet {
            // remove old ones
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview($0)}
            // add new ones
        }
    }
    
    var selectedMood: Mood? {
        didSet {
            guard let current = selectedMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil
                return
            }
            addMoodButton.setTitle("I'm \(current.name)", for: .normal)
            addMoodButton.backgroundColor = current.color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        
        addMoodButton.backgroundColor = .systemCyan
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    var moodsConfigurable: MoodsConfigurable!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedList":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("Expected MoodsConfigurable as destination")
            }
            
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        default:
            preconditionFailure("Unexpected segue")
        }
    }
    
    @objc func moodSelectionChanged(_ sender: UIButton) {
        guard let idx = moodButtons.firstIndex(of: sender) else {
            preconditionFailure("Unable to find the tapped button")
        }
        selectedMood = moods[idx]
    }
    
    @IBAction func addMoodTapped(_ sender: UIButton) {
        guard let selectedMood = selectedMood else { return }
        
        moodsConfigurable.add(MoodEntry(mood: selectedMood, timestamp: Date()))
    }
}

