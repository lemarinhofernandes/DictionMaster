//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation
import AVKit

class SearchViewModel {
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    private let repository = SearchRepository()
    
    init() {
        player = AVPlayer()
    }
    
    func getDefinition(for term: String) {
        switch shouldMakeRequest() {
        case true:
            repository.get(term, completion: { [weak self] result in
                switch result {
                case .success(let value):
                    print(value)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        case false:
            print("mandar para o paywall")
        }
    }
    
    func playAudio() {
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
    
    private func shouldMakeRequest() -> Bool {
        let requestCache = UserDefaults.standard.codableObject(dataType: RequestCache.self, key: nil)
        let timesCalled = requestCache?.timesCalled ?? 0
        
        guard let cache = requestCache else {
            increaseRequestCall(1)
            return true
        }
        
        if timesCalled >= 5 {
            return false
        }
        
        increaseRequestCall(timesCalled+1)
        return true
    }
    
    private func increaseRequestCall(_ timesCalled: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        let date = dateFormatter.string(from: Date())

        let codableObject = RequestCache(date: date, timesCalled: timesCalled)
        UserDefaults.standard.setCodableObject(codableObject, key: nil)
    }
    
}
