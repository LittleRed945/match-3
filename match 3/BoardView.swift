import Foundation
import SwiftUI
struct BoardView: View {
    @StateObject var game=game_variable()
    @State private var startDetectDrag = false
    @State private var number = 1
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
            if startDetectDrag {
            if value.translation.width > 5 {
            number += 1
                print(value.translation.width)
            startDetectDrag = false

            } else if value.translation.width < -5 {
            number -= 1

            startDetectDrag = false

            }
            } else {
            if value.translation == .zero {
            startDetectDrag = true
            }
            }
            })
    }
    var body: some View {
        VStack(spacing:0){
            ForEach(game.board.indices,id:\.self){y in
                HStack(spacing:0){
                    ForEach(game.board[y].indices,id:\.self){x in
                        ZStack{
                            Rectangle().stroke().frame(width: 30, height: 30)
                            Image("\(game.board[y][x].img_id)").gesture(dragGesture)
                        }
                        
                    }
                }
            }
        }.onAppear(){
            game.random_assign()
        
            print(game.board[0][0].img_id)
        }
        
    }
}
