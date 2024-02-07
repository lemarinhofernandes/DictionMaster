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
    func displayAlert(with text: String)
    func toggleIndicator(for isLoading: Bool)
}

final class SearchViewModel {
    weak var coordinator: MainCoordinator?
    private let repository = SearchRepository()
    var player: AVPlayer?
    var playerItem:AVPlayerItem?
    var delegate: ViewModelDelegate?
    private var isLoading: Bool = false {
        didSet {
            delegate?.toggleIndicator(for: self.isLoading)
        }
    }
    
    
    public static let shared = SearchViewModel()
    
    init() {
        player = AVPlayer()
    }
    
    func getDefinition(for term: String) {
        isLoading = true
        
        self.repository.get(term, completion: { [weak self] result in
            switch result {
            case .success(let value):
                self?.delegate?.callDefinitionViewController(with: value)
                self?.isLoading = false
            case .failure(let error):
                self?.handleError(with: error)
                self?.isLoading = false
                
            }
        })
        
        
    }
    
    func handleError(with error: ErrorsEnum) {
        switch error {
        case .NetworkError:
            delegate?.displayAlert(with: "AF network error")
        case .LimitError:
            delegate?.callPaywallViewController()
        }
    }
    
    func playAudio(with url: String) {
        let optionalUrl = URL(string: url)
        guard let url = optionalUrl else { return }
        
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
