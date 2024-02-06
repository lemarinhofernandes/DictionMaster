//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation
import Alamofire
import AVKit

class SearchViewModel {
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    
    init() {
        player = AVPlayer()
    }
    
    func makeRequest() {
        AF.request("https://api.dictionaryapi.dev/api/v2/entries/en/hello").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let value):
                guard let dataValue = value as? Data else { return }
                print(String(data: dataValue, encoding: .utf8)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testeAudio () {
        let url = URL(string: "https://api.dictionaryapi.dev/media/pronunciations/en/hello-uk.mp3")!
        print("playing \(url)")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("AVAudioSessionCategoryPlayback not work")
        }
        
        do {
            self.playerItem = AVPlayerItem(url: url)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 10.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
}
