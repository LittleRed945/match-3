import Foundation
import SwiftUI
struct TimerView: View {
    @StateObject var gameTimer = GameTimer()
    var body: some View {
        ZStack{
            Rectangle().fill(Color.black).frame(width:
                                                    100, height: 20)
            
            HStack{
                Rectangle().fill(Color.red).frame(width:
                                                    CGFloat(gameTimer.secondsElapsed), height: 20)
                Spacer()
            }
            
            Text("\(gameTimer.secondsElapsed)")
            
        }.onAppear(){gameTimer.start()}
        .padding(.trailing, 200.0)
    }
}
