//
//  ContentView.swift
//  match 3
//
//  Created by User02 on 2022/4/27.
//

import SwiftUI

struct ContentView: View { 
    var body: some View {
        VStack{
            TimerView()
            BoardView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
            ContentView()
            
        
        
    }
}
