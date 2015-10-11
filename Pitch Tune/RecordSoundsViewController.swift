//
//  RecordSoundsViewController.swift
//  Pitch Tune
//
//  Created by Yicheng Shao on 8/17/15.
//  Copyright (c) 2015 Dora Shao. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingProgress: UILabel!
    //created a variable called recordingProgress, the type of the label is UI label, the IBOutlet tells that the variable is not an ordinary variable, it is linked to the Interface builder somehow.
    // the key word, weak/strong help manage the memory of our variables, exclamation mark means the variable is optional, i.e. don't have to have a value.
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true
        recordButton.enabled=true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        //todo1: show text when the recording is in progress
        recordingProgress.hidden=false
        stopButton.hidden=false
        recordButton.enabled=false
        //todo2: actually record the voice
        println("in recordAudio")
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        //let currentDateTime = NSDate() //label the audio files according to current time
        //let formatter = NSDateFormatter()
        //formatter.dateFormat = "ddMMyyyy-HHmmss"
        //let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let recordingName  =  "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings:nil, error:nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        //audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording (recorder: AVAudioRecorder!, successfully flag: Bool){
        if(flag){
            //TODO1: save recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            //TODO2: move to the second scene aka perfor stage
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            println("recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //called right before a segue is passed, great place to send data
        if(segue.identifier == "stopRecording" ){
            let playSoundsVC: playSoundsViewController = segue.destinationViewController as playSoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
            
            
        }
    }
    

    @IBAction func stopRecording(sender: UIButton) {
        // todo1: hide the recordingProgress label
        recordingProgress.hidden=true
        recordButton.enabled=true
        //todo2: stop the recording progress
        audioRecorder.stop()
        var session = AVAudioSession.sharedInstance()
        session.setActive(false, error: nil)
    }
}

