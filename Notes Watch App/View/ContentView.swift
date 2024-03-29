//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Shazeen Thowfeek on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: properties
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //MARK: function
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        //dump(notes)
        do{
           //1.Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            //2.create a new URL to save the file using the getDocumentationDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            //3.write the data to the given URL
            try data.write(to: url)
            
        }catch{
            print("Printing data has failed.")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do{
                //1.get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                //2.Create a new property for the data
                let data = try Data(contentsOf: url)
                //3.decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            }catch{
                //do nothing
            }
        }
    }
    
    func delete(offsets: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    //MARK: Body
    
    var body: some View {
      
            
        NavigationView {
            VStack {
                HStack(alignment:.center, spacing: 6){
                    TextField("Add new note", text: $text)
                    
                    Button(action: {
                        //1.only run the button's action ehrn the text field is not empty
                        guard text.isEmpty == false else{ return }
                        //2.create a new note item and initialize it with the text value
                        let note = Note(id: UUID(), text: text)
                        //3.add the new note item to the notes array (append)
                        notes.append(note)
                        //4.make the text field empty
                        text = ""
                        //5.save the notes
                        save()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42,weight: .semibold))
                    })
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    ///.buttonStyle(BorderedButtonStyle(tint: .accentColor))
                }//hstack
                Spacer()
                //Text("\(notes.count)")
                if notes.count >= 1 {
                    List{
                        ForEach(0..<notes.count, id: \.self){ i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack{
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading,5)
                                }
                            }//hstack
                        }//loop
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                    Spacer()
                }//list
            }//vstack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
        })
        }
    }
}


//MARK: preview

#Preview {
    ContentView()
}
