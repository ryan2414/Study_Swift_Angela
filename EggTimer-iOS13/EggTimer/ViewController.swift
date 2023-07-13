//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timerNum = 0
    var totalNum = 0
    var timer: Timer?
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        progressBar.progress = 1.0
        titleLabel.text = "How do you like your eggs?"
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //기존에 타이머 동작중이면 중지 처리
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        
        guard let hardness = sender.currentTitle else { return }
        
        if let result = eggTimes[hardness] {
            //timerNum = result * 60
            //totalNum = result * 60
            timerNum = result
            totalNum = result
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)

        }
        

    }
    
    
    @objc func fire()
    {
        print(timerNum)
     
        //timerNum이 0이면(60초 경과) 타이머 종료
        if(timerNum <= 0) {
            timer?.invalidate()
            timer = nil
            
            //타이머 종료 후 처리...
            titleLabel.text = "Done!"
            
            playSound()
        }
     
        progressBar.progress = Float(timerNum)/Float(totalNum)
        //timerNum -1 감소시키기
        
        timerNum-=1
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
