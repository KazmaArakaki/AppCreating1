import UIKit
import AVKit

class AudioPlayer {
    static let shared = AudioPlayer()

    private var bgmAudioPlayer: AVAudioPlayer!
    private var seAudioPlayer: AVAudioPlayer!

    func playBGM() {
        guard
            let backgroundAudioData = AssetRegistry.shared.backgroundAudioData,
            let audioPlayer = try? AVAudioPlayer(data: backgroundAudioData)
        else {
            return
        }

        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
        audioPlayer.volume = 0
        audioPlayer.setVolume(1, fadeDuration: 3)

        self.bgmAudioPlayer = audioPlayer
    }

    func playButtonEffect() {
        guard
            let buttonEffectAudioData = AssetRegistry.shared.buttonEffectAudioData,
            let audioPlayer = try? AVAudioPlayer(data: buttonEffectAudioData)
        else {
            return
        }

        audioPlayer.play()

        self.seAudioPlayer = audioPlayer
    }
}
