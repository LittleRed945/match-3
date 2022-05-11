import Foundation
import SwiftUI
import AVFoundation
struct OverView: View {
    @Binding var time_out:Bool
    let player = AVPlayer()
    var highest:Int
    var body: some View {
        VStack{
            Text("Game").font(.largeTitle).foregroundColor(.white)
            Text("Over").font(.largeTitle).foregroundColor(.white)
            Text("Highest Score:\(highest)").foregroundColor(.white)
            HStack{
                //retry
                
                Button(action: {time_out.toggle()
                }, label:{
                    Image(systemName:"goforward").resizable().frame(width: 25, height: 25)
                })
            }
        }.onAppear{let fileUrl = Bundle.main.url(forResource: "lose", withExtension: "mp3")!
                   let playerItem = AVPlayerItem(url: fileUrl)
                   self.player.replaceCurrentItem(with: playerItem)
            self.player.play()}
    }
}
