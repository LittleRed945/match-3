
import Foundation
import SwiftUI
struct gem: Identifiable{
    var img_id=0
    var connected=false
    let id=UUID()
}
class game_variable: ObservableObject{
//    @Published var board=Array(repeating: Array(repeating: gem(), count: 8), count: 8)
    @Published var board=Array(repeating: gem(), count: 64)
    @Published var animation_end=true
    @Published var fall_col=Array(repeating: -1, count: 8)
    @Published var score=0
    @Published var time_out=false
    func reset(){
        animation_end=true
        fall_col=Array(repeating: -1, count: 8)
        score=0
        time_out=false
        random_assign()
        
    }
    func random_assign(){
        for i in board.indices {
                board[i]=gem()
                board[i].img_id=Int.random(in: 1..<6)
            while is_connect(i:i){
                    board[i].img_id=Int.random(in: 1..<6)
                }
            
        }
    }
    func is_connect(i:Int) -> Bool{
        if i%8 + 2  < 8 ,board[i].img_id==board[i+1].img_id,board[i].img_id==board[i+2].img_id{
            return true
        }else if i%8 - 2  >= 0 ,board[i].img_id==board[i-1].img_id,board[i].img_id==board[i-2].img_id{
            return true
        }else if Int(i/8) - 2 >= 0 ,board[i].img_id==board[i-8].img_id,board[i].img_id==board[i-8*2].img_id{
            return true
        }else if Int(i/8) + 2 < 8 ,board[i].img_id==board[i+8].img_id,board[i].img_id==board[i+8*2].img_id{
            return true
        }else if i%8 + 1  < 8,i%8 - 1 >= 0 ,board[i].img_id==board[i+1].img_id,board[i].img_id==board[i-1].img_id{
            return true
        }else if Int(i/8) - 1 >= 0 ,Int(i/8) + 1 < 8 ,board[i].img_id==board[i-8].img_id,board[i].img_id==board[i+8].img_id{
            return true
        }
        
        return false
    }
    func connected(){
        for i in board.indices{
            if is_connect(i: i)  {
                board[i].connected=true
                if i > fall_col[i%8]{
                    fall_col[i%8]=Int(i/8)
                }
            }
        }
    }
    func can_move_left(i:Int)->Bool{
        if (i-1) % 8 >= 0{
            return true
        }
        return false
    }
    func can_move_up(i:Int)->Bool{
        if Int(i/8) - 1 >= 0{
            return true
        }
        return false
    }
    func can_move_down(i:Int)->Bool{
        if Int(i/8) + 1 < 8{
            return true
        }
        return false
    }
    func can_move_right(i:Int)->Bool{
        if (i+1) % 8 < 8{
            return true
        }
        return false
    }
    func fall(i:Int){
        var now=i
        withAnimation(.default){
            while now >= 0{
                if now < 8 {
                    board[now].img_id=Int.random(in: 1..<6)
                }else{
                    
                    board[now]=board[now-8]
                    board[now-8] = gem()
                }
                now-=8
            }
        }
        if board[i].img_id>0{
            now = i-8
            var filled=true
            while now >= 0{
                if board[now].img_id==0{
                    fall_col[now % 8] = Int(now/8)
                    filled=false
                    break
                }
                now -= 8
            }
            if filled{
                fall_col[i%8] = -1
            }
        }
    }
    func connectAndFall(){
        connected()
        var continued = false
        withAnimation(.default){
            
            for i in board.indices{
                if board[i].connected{
                    continued=true
                    board[i]=gem()
                    score+=100
                }
            }
        }
        if continued{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
                
                for i in self.fall_col.indices{
                    while self.fall_col[i] >= 0{
                        self.fall(i: i+self.fall_col[i]*8)
                    }
                }
                connectAndFall()
            }
            
        }
    }
//    func random_assign(){
//        for y in board.indices {
//            for x in board[y].indices{
//                board[y][x].img_id=Int.random(in: 1..<6)
//                while is_connect(y:y,x:x){
//                    board[y][x].img_id=Int.random(in: 1..<6)
//                }
//            }
//        }
//    }
//    func is_connect(y:Int,x:Int) -> Bool{
//        if x+2<board[y].count,board[y][x].img_id==board[y][x+1].img_id,board[y][x].img_id==board[y][x+2].img_id{
//            return true
//        }
//        if y+2<board.count,board[y][x].img_id==board[y+1][x].img_id,board[y][x].img_id==board[y+2][x].img_id{
//            return true
//        }
//        return false
//    }
    
}
