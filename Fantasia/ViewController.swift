//
//  ViewController.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//  Music from Jukedeck
//  Images from Unsplash

import UIKit

var visualStimuli = [VisualStimulus]()
var auditoryStimuli = [AuditoryStimulus]()

func save(){
    NSUserDefaults.standardUserDefaults().setObject(visualStimuli, forKey: "visualStimuli")
    NSUserDefaults.standardUserDefaults().setObject(auditoryStimuli, forKey: "auditoryStimuli")
}

class ViewController: UIViewController {
    var imageStrings = [String]()
    var audioStrings = [String]()
    var timer = NSTimer()
    var current = 0;
    
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var happyFace: UIImageView!
    @IBOutlet weak var currentImage: UIImageView!

    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBOutlet weak var beginButton: UIButton!
    @IBAction func ratingSlider(sender: AnyObject) {
        visualStimuli[current].userImageRating = ratingSlider.value
        print(ratingSlider.value)
        current++
        run()
    }
    @IBAction func beginButton(sender: AnyObject) {
        //timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("run"), userInfo: nil, repeats: true)
        run()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        loadData()
        currentImage.hidden = true
        ratingSlider.hidden = true
        happyFace.hidden = true
        sadFace.hidden = true
    }
    
    func run(){
        currentImage.hidden = true
        beginButton.hidden = true
        happyFace.hidden = true
        sadFace.hidden = true
        ratingSlider.hidden = true
        var currentTime:Double = CACurrentMediaTime()
        auditoryStimuli[current].player.play()
        //play auditory stimulus for 8 seconds
        while((CACurrentMediaTime()-currentTime) < 8.0){}
        auditoryStimuli[current].player.stop()
        print(visualStimuli[current].image)
        currentImage.hidden = false
        currentImage.image = visualStimuli[current].image
        currentTime = CACurrentMediaTime()
        //show visual stimuli for 1 second
        while((CACurrentMediaTime()-currentTime) < 1.0){}
        currentImage.hidden = true
        happyFace.hidden = false
        sadFace.hidden = false
        ratingSlider.hidden = false
    }
    
    func loadData(){
        for i in 0...20 {
            imageStrings.append("image\(i).jpeg")
            audioStrings.append("audio\(i)")
        }
        visualStimuli.append(VisualStimulus(imageName: imageStrings[0], imageRating: 5))
        visualStimuli.append(VisualStimulus(imageName: imageStrings[1], imageRating: -4))
        auditoryStimuli.append(AuditoryStimulus(audioTrackName: audioStrings[0], audioTrackRating: -3))
        auditoryStimuli.append(AuditoryStimulus(audioTrackName: audioStrings[1], audioTrackRating: 2))
    }
    
    func pushToFirebase(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

