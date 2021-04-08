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
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture{
                        withAnimation(.linear(duration: 0.5)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
                }
                
        }
            .padding()
            .foregroundColor(.orange)
        Button("New Game", action: {
            withAnimation(.easeInOut(duration: 1)) {
                self.viewModel.resetGame()
            }
        })
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(pieStartAngle), endAngle: Angle.degrees(-animatedBonusRemaining*pieEndAngle+pieStartAngle), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(pieStartAngle), endAngle: Angle.degrees(-card.bonusRemaining*pieEndAngle+pieStartAngle), clockwise: true)
                    }
                }
                .padding(5.0).opacity(0.5)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(rotationEffectAngle()))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses:  false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    // MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.7
    private let pieStartAngle: Double = -90
    private let pieEndAngle: Double = 360
    
    
    private func rotationEffectAngle() -> Double {
        return card.isMatched ? 360 : 0
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}





