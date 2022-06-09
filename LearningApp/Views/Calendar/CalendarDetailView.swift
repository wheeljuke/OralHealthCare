//
//  CalendarDetailView.swift
//  LearningApp
//
//  Created by 洪偉倫 on 2022/5/26.
//

import SwiftUI

struct CalendarDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    @ObservedObject var timerManager = TimerManager()
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack(alignment: .leading) {
                
                Text("紀錄刷牙")
                    .font(.largeTitle)
                    //.bold()
                
                
                VStack(alignment: .center) {
                    
                    /*Text("刷牙時間")
                        .font(.title)
                    */
                    Text(String(format:"%.2f", timerManager.seconds))
                        .bold()
                        .font(.system(size: 100))
                    
                    CalendarDetailCard(color: .white, name: "上顎舌側", done: timerManager.seconds >= 20.0,time: 20)
                    CalendarDetailCard(color: .white, name: "上顎咬合側", done: timerManager.seconds >= 40.0,time: 40)
                    CalendarDetailCard(color: .white, name: "上顎頰側", done: timerManager.seconds >= 60.0,time: 60)
                    CalendarDetailCard(color: .white, name: "下顎舌側", done: timerManager.seconds >= 80.0,time: 80)
                    CalendarDetailCard(color: .white, name: "下顎咬合側", done: timerManager.seconds >= 100.0,time: 100)
                    CalendarDetailCard(color: .white, name: "下顎頰側", done: timerManager.seconds >= 120.0,time: 120)
                    
                }
                .frame(width: geo.size.width)
                

                
                HStack(alignment: .center) {
                    switch timerManager.mode {
                        
                    case .stopped:
                        
                        withAnimation {
                            
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(.white)
                                HStack(alignment: .center) {
                                    
                                    Button {
                                        
                                        timerManager.startTimer()
                                        
                                    } label: {
                                        
                                        Image(systemName: "play.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                }
                                .foregroundColor(.gray)
                            }
                            
                        }
                        
                        Spacer()
                        
                    case .running:
                        
                        withAnimation {
                            
                            ZStack {
                                
                                Rectangle()
                                
                                    .frame(height: 60)
                                    .foregroundColor(.white)
                                    
                                HStack(alignment: .center) {
                                    
                                    Button {
                                        
                                        timerManager.pauseTimer()
                                        
                                    } label: {
                                        
                                        Image(systemName: "pause.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    Button {
                                        
                                        timerManager.restartTimer()
                                        
                                    } label: {
                                        
                                        Image(systemName: "restart.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                    case .paused:
                        
                        withAnimation {
                            VStack {
                                ZStack {
                                    
                                    Rectangle()
                                        .frame(height: 60)
                                        .foregroundColor(.white)
                                    
                                    HStack(alignment: .center) {
                                        
                                        Button {
                                            
                                            timerManager.startTimer()
                                            
                                        } label: {
                                            
                                            Image(systemName: "play.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        
                                        Button {
                                            
                                            timerManager.restartTimer()
                                            
                                        } label: {
                                            
                                            Image(systemName: "restart.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        Button {
                                            model.records.append(Record(id: UUID(), date: Date(), duration: timerManager.seconds))
                                        } label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(height: 50)
                                                    .foregroundColor(.green)
                                                    .cornerRadius(10)
                                                    .shadow(color: .gray, radius: 5)
                                                Text("完成")
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    .foregroundColor(.gray)
                                }
                                
                                
                            }
                            
                            
                        }
                        
                        

                    }
                }
            }
            
        }.padding(.horizontal)
    }
}

enum mode {
    case running
    case paused
    case stopped
}


class TimerManager: ObservableObject {
    @Published var seconds = 0.0
    @Published var mode:mode = .stopped
    var timer = Timer()
    
    func startTimer() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.seconds += 0.01
        }
    }
    
    func pauseTimer() {
        
        timer.invalidate()
        mode = .paused
    }
    
    func restartTimer() {
        
        timer.invalidate()
        mode = .stopped
        seconds = 0.0
    }
    
    
}

struct CalendarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDetailView()
    }
}
