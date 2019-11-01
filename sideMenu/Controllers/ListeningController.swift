//
//  ListeningController.swift
//  sideMenu
//
//  Created by Thidar Phyo on 9/23/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit
import AVKit

class ListeningController: UIViewController, UIWebViewDelegate {
    
    var player : AVAudioPlayer!
    

    @IBOutlet weak var pdfView: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func play(_ sender: UIBarButtonItem) {
        player.play()
        updateRemainingTime()
    }
    func updateRemainingTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.player.isPlaying {
                let remTime = self.player.duration - self.player.currentTime
                //print(remTime)
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.hour, .minute, .second]
                formatter.unitsStyle = .positional
//                10000.asString(style: .positional)  // 2:46:40
//                10000.asString(style: .abbreviated) // 2h 46m 40s
//                10000.asString(style: .short)       // 2 hr, 46 min, 40 sec
//                10000.asString(style: .full)        // 2 hours, 46 minutes, 40 seconds
//                10000.asString(style: .spellOut)    // two hours, forty-six minutes, forty seconds
//                10000.asString(style: .brief)       // 2hr 46min 40sec
                let formattedString = formatter.string(from: TimeInterval(remTime))!
                print(formattedString)
                self.slider.value = Float(self.player.currentTime / self.player.duration)
                self.timeLabel.text = String(formattedString)
            }else {
                timer.invalidate()
            }
            
        }
        
        
    }
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func pause(_ sender: UIBarButtonItem) {
        player.pause()
    }
    
    @IBAction func changeTiming(_ sender: UISlider) {
        let value = sender.value
        player.currentTime = player.duration * Double(value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fileURL = Bundle.main.url(forResource: "N3Sample", withExtension: "mp3"){
            do {
                player = try AVAudioPlayer(contentsOf: fileURL)
                print("Player createdd")
                //player.play()
            } catch {
                print("Audio file not found")
            }
        }
        pdfView.delegate = self
        spinner.hidesWhenStopped = true
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "JLPT-N3-Practice-Test-listening-section", ofType: "pdf")!)
        let request = URLRequest(url: path)
        pdfView.loadRequest(request)
        
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        spinner.startAnimating()
        return true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        spinner.stopAnimating()
        print("Something went wrong")
    }

}
