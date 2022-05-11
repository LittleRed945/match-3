import Foundation
import SwiftUI
import AVFoundation
struct BoardView: View {
    @StateObject var game=game_variable()
    @Binding var highest:Int
    @State private var startDetectDrag = false
    @State private var number = 1
    let player = AVPlayer()
   
    func dragGesture(index:Int,game:game_variable)->some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
                if startDetectDrag {
                    //move right
                    if value.translation.width > 5 ,game.can_move_right(i: index) ,game.animation_end{
                        game.animation_end=false
                        //swap
                        withAnimation(.easeInOut(duration: 0.3)){
                            let tmp=game.board[index]
                            game.board[index]=game.board[index+1]
                            game.board[index+1]=tmp
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if !game.is_connect(i: index),!game.is_connect(i: index+1){
                                game.animation_end=false
                                withAnimation(.easeInOut(duration: 0.3)){
                                    let tmp=game.board[index]
                                    game.board[index]=game.board[index+1]
                                    game.board[index+1]=tmp
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    game.animation_end=true
                                }
                            }
                            else{
//                                withAnimation(.default){
//                                    game.connected()
//                                    for i in game.board.indices{
//                                        if game.board[i].connected{
//                                            game.board[i]=gem()
//                                        }
//                                    }
//                                }
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
//
//                                    for i in game.fall_col.indices{
//                                        while game.fall_col[i] >= 0{
//                                            game.fall(i: i+game.fall_col[i]*8)
//                                        }
//                                    }
//                                }
                                game.connectAndFall()
                                game.animation_end=true
                            }
                        }
                        startDetectDrag = false
                        
                    }
                    //move left
                    else if value.translation.width < -5 ,game.can_move_left(i: index),game.animation_end{
                        game.animation_end=false
                        //swap
                        withAnimation(.easeInOut(duration: 0.3)){
                            let tmp=game.board[index]
                            game.board[index]=game.board[index-1]
                            game.board[index-1]=tmp
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if !game.is_connect(i: index),!game.is_connect(i: index-1){
                                game.animation_end=false
                                withAnimation(.easeInOut(duration: 0.3)){
                                    let tmp=game.board[index]
                                    game.board[index]=game.board[index-1]
                                    game.board[index-1]=tmp
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    game.animation_end=true
                                }
                            }else{
                                game.connectAndFall()
                                game.animation_end=true
                                
                            }
                        }
                        startDetectDrag = false
                        
                    }
                    //move up
                    else if value.translation.height < -5 ,game.can_move_up(i: index),game.animation_end{
                        game.animation_end=false
                        //swap
                        withAnimation(.easeInOut(duration: 0.3)){
                            let tmp=game.board[index]
                            game.board[index]=game.board[index-8]
                            game.board[index-8]=tmp
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if !game.is_connect(i: index),!game.is_connect(i: index-8){
                                game.animation_end=false
                                withAnimation(.easeInOut(duration: 0.3)){
                                    let tmp=game.board[index]
                                    game.board[index]=game.board[index-8]
                                    game.board[index-8]=tmp
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    game.animation_end=true
                                }
                            }
                            else{
                                game.connectAndFall()
                                game.animation_end=true
                               
                            }
                        }
                        startDetectDrag = false
                        
                    }
                    //move down
                    else if value.translation.height > 5 ,game.can_move_down(i: index),game.animation_end{
                        game.animation_end=false
                        //swap
                        withAnimation(.easeInOut(duration: 0.3)){
                            let tmp=game.board[index]
                            game.board[index]=game.board[index+8]
                            game.board[index+8]=tmp
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if !game.is_connect(i: index),!game.is_connect(i: index+8){
                                game.animation_end=false
                                withAnimation(.easeInOut(duration: 0.3)){
                                    let tmp=game.board[index]
                                    game.board[index]=game.board[index+8]
                                    game.board[index+8]=tmp
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    game.animation_end=true
                                }
                            }else{
                                game.connectAndFall()
                                game.animation_end=true
                                
                            }
                        }
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
        let columns = [GridItem(), GridItem(),GridItem(), GridItem(),GridItem(), GridItem(),GridItem(), GridItem()]
            
            VStack{
                HStack{
                
                    //random
                    Button(action: {game.random_assign()
                    }, label: {
                        Text("random").foregroundColor(.black).background(Rectangle().fill(.white))
                    })
                        .padding(.trailing, 100.0)
                    
                    VStack(alignment: .leading){
                        Text("Score").background(Rectangle().fill(.white))
                        Text("\(game.score)").background(Rectangle().fill(.white))
                    }
                    .padding(.leading, 100.0)
                }
                LazyVGrid(columns: columns) {
                    ForEach(Array(game.board.enumerated()),id:\.element.id){index,tile in
                        Image("\(tile.img_id)").gesture(dragGesture(index:index,game:game))
                            .onChange(of: game.score, perform: {value in
                                      if highest < game.score{
                                highest=game.score
                                      }})
                    }
                    
                    
                }
                .onAppear(){
                    game.random_assign()
                    
                    let fileUrl = Bundle.main.url(forResource: "battle", withExtension: "mp3")!
                    let playerItem = AVPlayerItem(url: fileUrl)
                    self.player.replaceCurrentItem(with: playerItem)
                    self.player.play()
                    
                }
            }
        
        
        
    }
}
