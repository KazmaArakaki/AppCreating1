import UIKit
import AVKit

class AssetRegistry {
    static let shared = AssetRegistry()

    var directoryUrl: URL {
        get {
            let directoryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
                .appendingPathComponent("Assets", isDirectory: true)

            if !FileManager.default.fileExists(atPath: directoryUrl.path) {
                try! FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true, attributes: nil)
            }

            return directoryUrl
        }
    }

    var backgroundAudioData: Data? {
        let remoteUrl = URL(string: "https://app-creating-1.arakaki.app/audio/Background.mp3")!

        let localUrl = directoryUrl.appendingPathComponent("Background.mp3")

        if FileManager.default.fileExists(atPath: localUrl.path) {
            return try? Data(contentsOf: localUrl)
        }

        if let data = try? Data(contentsOf: remoteUrl) {
            if (try? data.write(to: localUrl)) != nil {
                return data
            }
        }

        return nil
    }

    var buttonEffectAudioData: Data? {
        let remoteUrl = URL(string: "https://app-creating-1.arakaki.app/audio/ButtonEffect.mp3")!

        let localUrl = directoryUrl.appendingPathComponent("ButtonEffect.mp3")

        if FileManager.default.fileExists(atPath: localUrl.path) {
            return try? Data(contentsOf: localUrl)
        }

        if let data = try? Data(contentsOf: remoteUrl) {
            if (try? data.write(to: localUrl)) != nil {
                return data
            }
        }

        return nil
    }

    var questionPickAnimationPlayerItem: AVPlayerItem? {
        get {
            let remoteUrl = URL(string: "https://app-creating-1.arakaki.app/video/Steward_Sample.mp4")!

            let localUrl = directoryUrl.appendingPathComponent("QuestionPickAnimation.mp4")

            if FileManager.default.fileExists(atPath: localUrl.path) {
                return AVPlayerItem(url: localUrl)
            }

            if let data = try? Data(contentsOf: remoteUrl) {
                if (try? data.write(to: localUrl)) != nil {
                    return AVPlayerItem(url: localUrl)
                }
            }

            return nil
        }
    }
}
