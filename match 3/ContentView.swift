//
//  ContentView.swift
//  match 3
//
//  Created by User02 on 2022/4/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameTimer = GameTimer()
    @AppStorage("Highest_Score") var highest: Int = 0
    var body: some View {
        if !gameTimer.time_out{
            VStack{
                TimerView(gameTimer: gameTimer)
                BoardView(highest: $highest)
            }.background( Image("Wordle_background").scaledToFill())
        }else{
            OverView(time_out: $gameTimer.time_out, highest: highest)
        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
            ContentView()
            
        
        
    }
}
