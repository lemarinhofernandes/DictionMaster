//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation
import AVKit

protocol ViewModelDelegate {
    func callDefinitionViewController(with definition: DefinitionModel)
    func callPaywallViewController()
}

class SearchViewModel {
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    private let repository = SearchRepository()
    var delegate: ViewModelDelegate?
    
    public static let shared = SearchViewModel()
    
    init() {
        player = AVPlayer()
    }
    
    func getDefinition(for term: String) {
        self.repository.get(term, completion: { [weak self] result in
            switch result {
            case .success(let value):
                self?.delegate?.callDefinitionViewController(with: value)
            case .failure(let error):
                self?.handleError(with: error)
            }
        })
    }
    
    func handleError(with error: ErrorsEnum) {
        switch error {
        case .NetworkError:
            print("AF network error")
        case .LimitError:
            delegate?.callPaywallViewController()
        }
    }
    
    func playAudio(with url: String) {
        let optionalUrl = URL(string: url)
        guard let url = optionalUrl else { return }
        
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
