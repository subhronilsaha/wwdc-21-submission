//
//  PageOneView.swift
//  BookCore
//
//  Created by Subhronil Saha on 12/04/21.
//

import SwiftUI
import SpriteKit
import AVKit

//MARK:- Page One Content View
public struct PageTwoView: View {
    
    @State var audioPlayer: AVAudioPlayer!

    // BODY
    public var body: some View {
            
        VStack {
            
            Spacer()
            
            Maze()
            
            // Footer
            HStack {
                Spacer()
                Text("Play/Pause Music ")
                Button(action: {
                    self.audioPlayer.play()
                }) {
                    Image(systemName: "play.circle.fill").resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                }
                Button(action: {
                    self.audioPlayer.pause()
                }) {
                    Image(systemName: "pause.circle.fill").resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fit)
                }
            }.padding(10)
            
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "piano-bg-music", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
    
    // Empty constructor - Required to avoid crash
    public init() {
        //
    }
}

public struct Maze: View {
    
    @State var pathTiles : Array<MazeLocation> = []
    
    public var map:Array<Int> = [
        1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 2
    ]
    
    public var map2D = [
        [1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 0, 0, 1],
        [1, 0, 0, 0, 1, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1]
    ]
    func getNum(index:Int, innerIndex:Int) -> Int{
        let index = index*8+innerIndex
        return map[index]
    }
    
    func getColor(index:Int, innerIndex:Int) -> Color {
        let _index = index * 8 + innerIndex
        var color:Color = .white
        
        if index % 2 == 0 {
            color = _index % 2 == 0 ? Color.purple : Color.orange
        }
        else {
            color = _index % 2 != 0 ? Color.purple : Color.orange
        }
        if _index == 63 {
            color = Color.red
        }
        if _index == 0 {
            color = Color.green
        }
        
        // check if part of path
        if self.pathTiles.contains(MazeLocation(row: index, col: innerIndex)) == true {
            color = Color.green
        }
        
        return color
    }
    
    public var body: some View {
        VStack(spacing: 0){
            ForEach(0..<8, id: \.self) { index in
                HStack(spacing: 0){
                    ForEach(0..<8, id: \.self) { innerIndex in
                        if getNum(index: index, innerIndex: innerIndex) == 1 || getNum(index: index, innerIndex: innerIndex) == 2 {
                            ZStack(alignment: .center){
                                
                                Circle().fill(getColor(index:index, innerIndex:innerIndex)).frame(width: 40, height: 40, alignment: .center)
                            }.id(index*innerIndex)
                        }
                        
                        else {
                            ZStack(alignment: .center){
                                Circle().fill(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0)).frame(width: 40, height: 40, alignment: .center)
                            }.id(index*innerIndex)
                        }
                    }
                }.id(index)
            }
        }
    }
    
}

enum Cell: Int {
    case Empty = 1
    case Blocked = 0
    case Key = 5
    case Goal = 2
    case NotFound = -1
}


struct MazeLocation: Hashable {
    let row: Int
    let col: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(row.hashValue ^ col.hashValue)
    }
    var hashValue: Int { return row.hashValue ^ col.hashValue }
}
