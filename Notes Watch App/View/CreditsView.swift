//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Shazeen Thowfeek on 29/03/2024.
//

import SwiftUI

struct CreditsView: View {
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String{
        return "developer-no\(randomNumber)"
    }
    
    var body: some View {
        VStack(spacing: 3){
            //profile image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            //header
            HeaderView(title: "Credits")
            //content
            Text("Shazeen Thowfeek")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }//vstack
    }
}

#Preview {
    CreditsView()
}
