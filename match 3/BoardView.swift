import Foundation
import SwiftUI
struct BoardView: View {
    @StateObject var game=game_variable()
    var body: some View {
        VStack{
            ForEach(game.board.indices,id:\.self){y in
                HStack{
                    ForEach(game.board[y].indices,id:\.self){x in
                        ZStack{
                            Rectangle().stroke().frame(width: 30, height: 30)
                            Image("\(game.board[y][x].img_id)")
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
