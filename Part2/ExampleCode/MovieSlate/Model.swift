//
//  Model.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/15/20.
//

import Foundation
import AVFoundation
import SwiftUI


class Model : NSObject, ObservableObject{
    override init() {
        super.init()
        self.speechSynthesizer.delegate = self
    }
    @Published var productionName:String = "Your Project"
    @Published var season:String = ""
    @Published var episode:String = ""
    @Published var scene:String = "1"
    @Published var shot:String = ""
    @Published var take:String = "1"
    
    var fullProductionName:String {
        var name = ""
        if !productionName.isEmpty {
            name += productionName
        }

        if !season.isEmpty {
            name += " Season " + season
        }

        if !episode.isEmpty {
            name += " Episode " + episode
        }

        return name
    }
    
    private var speechSynthesizer = AVSpeechSynthesizer()
    var finalSpeechUtterance:AVSpeechUtterance!
    var audioPlayer:AVAudioPlayer!

}

extension Model: AVSpeechSynthesizerDelegate, AVAudioPlayerDelegate {
    func playSlate()
    {
        let voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())
        
        let utterance1 = AVSpeechUtterance(string: fullProductionName)
        utterance1.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance1.voice = voice
        utterance1.postUtteranceDelay = 0.125
        utterance1.volume = 1.0
        
/*        let utterance1a = AVSpeechUtterance(string: shot.lowercased())
        utterance1a.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance1a.voice = voice
        utterance1a.postUtteranceDelay = 0.125
        utterance1a.volume = 1.0
*/
  
        var sceneText = "scene " + scene
        if self.shot != "" {
            sceneText = sceneText + " " + self.shot
        }
        
        let utterance2 = AVSpeechUtterance(string: sceneText)
        utterance2.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance2.voice = voice
        utterance2.postUtteranceDelay = 0.125
        
        let utterance3 = AVSpeechUtterance(string: "Take " + take)
        utterance3.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance3.voice = voice

        self.finalSpeechUtterance = utterance3
        self.speechSynthesizer.delegate = self
        
        self.speechSynthesizer.speak(utterance1)
        
        //if self.shot != "" {
        //    self.speechSynthesizer.speak(utterance1a)
        //}
        
        self.speechSynthesizer.speak(utterance2)
        self.speechSynthesizer.speak(utterance3)
    }
    
    func speechSynthesizer(_ _synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance)
    {
        if (self.finalSpeechUtterance == utterance)
        {
            playBeepAudio()
        }
    }

    func playBeepAudio()
    {
        // Build URL
        let filePath:String! = Bundle.main.path(forResource: "shorter-beep", ofType: "wav")
        
        if (filePath == nil)
        {
            return;
        }
        
        let url = URL(fileURLWithPath: filePath)
        // Create Audio Player object
        self.audioPlayer = createAudioPlayer(url)
        
        if self.audioPlayer != nil
        {
            // Set delegate
            audioPlayer.delegate = self
            self.audioPlayer.volume = 1.0;
            
            if (!self.audioPlayer.prepareToPlay())
            {
                return
            }
            
            if (self.audioPlayer.play())
            {
                return
            }
        }

    }
    
    func createAudioPlayer(_ url: URL) -> AVAudioPlayer!
    {
        // Create Audio Player object
        var openError : NSError?
        var player:AVAudioPlayer!
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error as NSError {
            openError = error
            player = nil
        }
        
        // Handle and display errors
        if player == nil
        {
            displayError("Unable to create Audio Player")
            return nil
        }
        
        if let error = openError
        {
            displayError(error.localizedDescription)
            return nil
        }
        
        return player
    }
    
    func displayError(_ errorText:String)
    {
        /*
        if NSClassFromString("UIAlertController") != nil
        {
            // New - iOS 8 way - of displaying alerts
            let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            // Create UIAlertView (iOS 7 and before)
            
            // The following mechanism for creating a UIAlertView causes app crash in Xcode 6-Beta 1
            // var alertView = UIAlertView(title: "Error", message: errorText, delegate: nil, cancelButtonTitle: "Ok")
            let alertView = UIAlertView()
            alertView.title = "Error"
            alertView.message = errorText
            alertView.addButton(withTitle: "Ok")
            alertView.show()
        } */
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
    }
}

// ::MARK:: State restoration
extension Model {
    func restore(from activity: NSUserActivity) {
        productionName = activity.userInfo?[Key.productionName] as? String ?? "Your Production"
        season = activity.userInfo?[Key.season] as? String ?? ""
        episode = activity.userInfo?[Key.episode] as? String ?? ""
        scene = activity.userInfo?[Key.scene] as? String ?? "1"
        shot = activity.userInfo?[Key.shot] as? String ?? ""
        take = activity.userInfo?[Key.take] as? String ?? "1"
      }
      
      func store(in activity: NSUserActivity) {
          activity.addUserInfoEntries(from: [Key.productionName: productionName, Key.season: season, Key.episode: episode, Key.scene: scene, Key.shot: shot, Key.take: take])
      }
      
      private enum Key {
        static let productionName = "production"
        static let season = "season"
        static let episode = "episode"
        static let scene = "scene"
        static let shot = "shot"
        static let take = "take"
      }
}

extension Bundle {
    var activityType: String {
        return Bundle.main.infoDictionary?["NSUserActivityTypes"].flatMap { ($0 as? [String])?.first } ?? ""
    }
}
