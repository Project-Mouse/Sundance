//
//  PlayerUIView.swift
//  Sundance
//
//  Created by Imran razak on 28/06/2024.
//

import Foundation
import AVFoundation
import SwiftUI

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    
    init(player: AVPlayer) {
        super.init(frame: .zero)
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

