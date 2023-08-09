//
//  ContentView.swift
//  ChatGPTintro
//
//  Created by Almat Kairatov on 08.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private Variables
    private let foregroundColors: [Color] = [.blue, .yellow, .red, .green, .purple, .orange, .pink, .teal, Color(uiColor: #colorLiteral(red: 0.04696316272, green: 0.06727208942, blue: 0.2167890072, alpha: 1))]
    private let backgroundColors: [Color] = [Color(uiColor: #colorLiteral(red: 0.1860292554, green: 0.17613253, blue: 0.1892024577, alpha: 1)), .gray, .cyan, .indigo, .mint, .red, .green, .yellow, .purple]
    
    private let slogan = [
        "Let's Create",
        "Think",
        "Let's BrainStorm",
        "Imagine",
        "Innovate",
        "Design",
        "Collaborate",
        "Build",
        "Explore",
        "Inspire",
        "Dream",
        "Express",
        "Iterate",
        "Problem Solve"
    ]

    // MARK: - State Properties
    @State private var index = 8
    @State private var sloganInd = 0
    @State private var textLength: CGFloat? = nil
    
    var body: some View {
        VStack {
            HStack(alignment: .center){
                Circle().frame(width: 45)
                    .foregroundColor(foregroundColors[index])
                    .background {
                        HStack {
                            Text(slogan[sloganInd])
                                .font(.system(size: 40))
                                .frame(width: textLength)
                                .foregroundColor(foregroundColors[index])
                        }
                        .frame(width: textLength)
                        .clipped()
                        // MARK: - Text offset depending text width -> -((textLength ?? 0) + 45)/2 - 5
                        .offset(x: textLength == 0 ? 0 : -((textLength ?? 0) + 45)/2 - 5)
                    }
                    .offset(x: textLength == 0 ? 0 : ((textLength ?? 0) + 45)/2)
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColors[index])
        .onAppear(perform: {
            textSize(slogan[sloganInd])
            intro()
        })
    }
    private func textSize(_ text : String){
            textLength = NSString(string: text)
            .size(withAttributes: [.font: UIFont
                .systemFont(ofSize: 40)]).width
        }
    private func intro() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.3)) {
                textLength = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if textLength == 0 {
                    // Prevent Duplicate
                    var oldIndex = index
                    repeat {
                        index = Int.random(in: 0..<foregroundColors.count)
                    } while index == oldIndex
                    
                    oldIndex = sloganInd
                    repeat {
                        sloganInd = Int.random(in: 0..<slogan.count)
                    } while sloganInd == oldIndex

                    // Resize to new text
                    withAnimation(.easeInOut(duration: 0.3)) {
                        textSize(slogan[sloganInd])
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
