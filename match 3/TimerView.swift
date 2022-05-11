import Foundation
import SwiftUI
struct TimerView: View {
    @ObservedObject var gameTimer :GameTimer
    var body: some View {
        ZStack{
            Rectangle().fill(Color.black).frame(width:
                                                    100, height: 20)
            
            HStack{
                Rectangle().fill(Color.red).frame(width:
                                                    CGFloat(gameTimer.secondsElapsed), height: 20)
                Spacer()
            }
//            HStack{
//                Image("heart(boarder)")
//                    .padding(.trailing, 100.0)
//            }
            HStack{
                Text("\(gameTimer.secondsElapsed)").background(Image("heart(boarder)").offset(x:-5,y:5))
                Spacer()
                
            }

                
                
            
        }.onAppear(){gameTimer.start()}
        .padding(.trailing, 200.0)
    }
}
