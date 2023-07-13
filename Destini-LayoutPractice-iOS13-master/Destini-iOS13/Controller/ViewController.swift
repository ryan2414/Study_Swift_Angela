//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI(index: 0)
      
    }


    @IBAction func choiceMode(_ sender: UIButton) {
        
        let index = storyBrain.changePage(buttonTitle: sender.currentTitle!)
        
        updateUI(index: index)
    }
    
    func updateUI(index: Int) {
        storyLabel.text = storyBrain.story[index].title
        choice1Button.setTitle(storyBrain.story[index].choice1, for: .normal)
        choice2Button.setTitle(storyBrain.story[index].choice2, for: .normal)
    }
}

