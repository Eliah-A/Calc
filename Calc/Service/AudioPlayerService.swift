//
//  AudioPlayerService.swift
//  Calc
//
//  Created by Илья Сергеевич on 21.01.2023.
//

import Foundation
import AVFoundation
import XCTest

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click",  ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

