//
//  playSoundsViewController.swift
//  Pitch Tune
//
//  Created by Yicheng Shao on 8/21/15.
//  Copyright (c) 2015 Dora Shao. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            //let fileUrl = NSURL(string: filePath) works the same as the line below
//            let filePathUrl = NSURL(fileURLWithPath: filePath)
//           audioPlayer = AVAudioPlayer(contentsOfURL:filePathUrl, error:nil)
//           audioPlayer.enableRate = true
//    
//        }
//        else{ println("the file path is empty")}
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error:nil)
        audioPlayer.enableRate = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SnailAction(sender: UIButton) {
        audioPlayer.stop()//just for good practice
        audioPlayer.rate = 0.5//play slowly, speed up is 2, normal speed is 1
        audioPlayer.play()
    }

    @IBAction func FastAction(sender: UIButton) {
        audioPlayer.stop()//just for good practice
        audioPlayer.rate = 1.5//play fast
        audioPlayer.play()
    }
  
    @IBAction func StopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
