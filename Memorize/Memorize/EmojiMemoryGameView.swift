//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 홍성준 on 2021/03/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.orange)
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
