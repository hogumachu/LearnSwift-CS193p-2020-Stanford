//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 홍성준 on 2021/03/22.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func randomEmoji() -> String {
        let range = 0x1F300...0x1F3F0
        let index = Int(arc4random_uniform(UInt32(range.count)))
        let ord = range.lowerBound + index
        guard let scalar = UnicodeScalar(ord) else { return "❓" }
        return String(scalar)
    }
    
    
    static func createMemoryGame() -> MemoryGame<String> {
        let randomNum = Int.random(in: 2...5)
        var emojis: Array<String> = []//["👻", "🎃", "🕷"]
        
        for _ in 1...randomNum {
            emojis.append(randomEmoji())
        }
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: -Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}

