import Foundation
class GameTimer: ObservableObject {
    private var frequency = 1.0
    private var timer: Timer?
    private var startDate: Date?
    @Published var secondsElapsed = 99
    @Published var time_out = false
    func start() {
        time_out=false
        secondsElapsed = 99
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true)
            { [weak self] timer in
                if let self = self,
                let startDate = self.startDate {
                    self.secondsElapsed = 99 + Int(round(startDate.timeIntervalSince1970 -
                        timer.fireDate.timeIntervalSince1970) )
                }
                if let self = self,self.secondsElapsed < 0{
                    self.secondsElapsed=0
                    
                }
            }
        
    }
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
