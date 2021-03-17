//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation //para reproducir sonidos
class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]//Creación de diccionario
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //Invalidar el timer al pulsar un nuevo botón para que solo haya 1 a la vez
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        totalTime = eggTimes[hardness]!
        //Reiniciar la progressBar, cuenta y titulo al pulsar un nuevo botón
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(secondPassed < totalTime) {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            /*if secondPassed == totalTime {
                timer.invalidate()
                titleLabel.text = "DONE!"
                playSound()
            }*/
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    
}
