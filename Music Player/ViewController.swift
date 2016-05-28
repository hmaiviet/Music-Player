//
//  ViewController.swift
//  Music Player
//
//  Created by VietHung on 5/27/16.
//  Copyright © 2016 VietHung. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    var repeating = false
    var playing = false
    var audio = AVAudioPlayer()
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var lbl_CurrentTime: UILabel!
    @IBOutlet weak var lbl_TotalTime: UILabel!
    @IBOutlet weak var sld_Duration: UISlider!
    
    
    @IBAction func Repeat(sender: UISwitch) {
        if(sender.on == true){
            repeating = true
            audio.numberOfLoops = -1
        }
        else{
            repeating = false
            audio.numberOfLoops = 0
        }
    }
    
    @IBAction func action_PlayPause(sender: AnyObject) {
        addThumbImgForButton()
        if(playing == false){
            audio.play()
            playing = true
        }
        else{
            audio.pause()
            playing = false
        }
    }
    
  
    @IBAction func sld_Duration(sender: UISlider) {
        audio.currentTime = Double(sender.value) * audio.duration
    }
    
    @IBAction func sld_Volume(sender: UISlider) {
        audio.volume = sender.value
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Reverie", ofType: ".mp3")!))
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("TimeUpdate"), userInfo: nil, repeats: true)
        audio.prepareToPlay()
        audio.delegate = self
        addThumbImgForSlider()
    }

    @IBOutlet weak var sld_Volume: UISlider!
    
    func addThumbImgForSlider(){
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumb2.png"), forState: .Highlighted)
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), forState: .Normal)
    }
    
    func TimeUpdate(){
        let m = Int(floor(audio.currentTime/60))
        let s = Int(round(audio.currentTime - Double(m)*60))
        let md = Int(floor(audio.duration/60))
        let sd = Int(round(audio.duration - Double(md)*60))
        self.lbl_CurrentTime.text = String(m) + ":" + String(s)
        self.lbl_TotalTime.text = String(md) + ":" + String(sd)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
    }
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        playing = true
        addThumbImgForButton()
    }
    
    func addThumbImgForButton(){
        if(playing == true){
            btn_Play.setBackgroundImage(UIImage(named:"playbutton.png"), forState: .Normal)
        }
        else{
            btn_Play.setBackgroundImage(UIImage(named: "pausebutton.png"), forState: .Normal)
        }
    }
    
  }

