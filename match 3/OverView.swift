import Foundation
import SwiftUI
struct OverView: View {
    @Binding var time_out:Bool
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
        }.background(Rectangle().fill(.black).scaledToFill())
    }
}
