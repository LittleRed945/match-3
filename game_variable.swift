//
//  game_variable.swift
//  match 3
//
//  Created by User02 on 2022/4/27.
//

import Foundation
struct gem{
    var img_id=0
}
class game_variable{
    @Published var board=Array(repeating: Array(repeating: gem(), count: 8), count: 8)
    func random_assign(){
        for y in board.indices {
            for x in board[y].indices{
                
            }
        }
    }
    
}
