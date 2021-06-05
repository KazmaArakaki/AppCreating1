import UIKit
import AVKit

protocol TopicsPickAnimationViewDelegate {
    func topicsPickAnimationView(videoEndedWith avPlayerItem: AVPlayerItem)
}

extension TopicsPickAnimationViewDelegate {
    func topicsPickAnimationView(videoEndedWith avPlayerItem: AVPlayerItem) {}
}

class TopicsPickAnimationView: UIView {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var delegate: TopicsPickAnimationViewDelegate?

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    func playVideo() {
        player.seek(to: .zero)

        player.play()
    }

    private func initialize() {
        let bundle = Bundle(for: type(of: self))

        if let customView = bundle.loadNibNamed("TopicsPickAnimationView", owner: self, options: nil)?.first as? UIView {
            customView.frame = bounds

            addSubview(customView)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(avPlayerItemDidPlayToEndTime(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)

        player = AVPlayer(playerItem: AssetRegistry.shared.questionPickAnimationPlayerItem)
        playerLayer = AVPlayerLayer(player: player)

        playerLayer.videoGravity = .resizeAspectFill

        videoView.layer.addSublayer(playerLayer)
    }

    @objc private func avPlayerItemDidPlayToEndTime(_ sender: Notification) {
        if let avPlayerItem = sender.object as? AVPlayerItem {
            delegate?.topicsPickAnimationView(videoEndedWith: avPlayerItem)
        }
    }
}
