
import Foundation
struct gem{
    var img_id=0
    var connected=false
}
class game_variable: ObservableObject{
    @Published var board=Array(repeating: Array(repeating: gem(), count: 8), count: 8)
    func random_assign(){
        for y in board.indices {
            for x in board[y].indices{
                board[y][x].img_id=Int.random(in: 1..<9)
                while is_connect(y:y,x:x){
                    board[y][x].img_id=Int.random(in: 1..<9)
                }
            }
        }
    }
    func is_connect(y:Int,x:Int) -> Bool{
        if x+2<board[y].count,board[y][x].img_id==board[y][x+1].img_id,board[y][x].img_id==board[y][x+2].img_id{
            return true
        }
        if y+2<board.count,board[y][x].img_id==board[y+1][x].img_id,board[y][x].img_id==board[y+2][x].img_id{
            return true
        }
        return false
    }
    
}
