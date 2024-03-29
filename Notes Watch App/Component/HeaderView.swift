//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Shazeen Thowfeek on 29/03/2024.
//

import SwiftUI

struct HeaderView: View {
    var title: String = ""
    
    
    var body: some View {
        VStack {
            //title
            if title != ""{
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            //seperater
            HStack{
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
        }//vstack
    }
}

#Preview {
    Group {
        HeaderView(title: "Credits")
        HeaderView()
    }
}
