//
//  ContentView.swift
//  NSPasteboard
//
//  Created by Bob Moriasi on 9/4/23.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    @State var currentPbContentString: String? = NSPasteboard.general.string(forType: .string)
    
    var body: some View {
        VStack {
            title
            
            Spacer().frame(height: 50)
            
            textInput
            
            HStack {
                copyButton
                clearButton
            }
            
            currentPbContent
            
            Spacer()
        }
        .padding()
    }
    
    var title: some View {
        Text("Pasteboard").font(.largeTitle)
    }
    
    var textInput: some View {
        HStack {
            Label("Text input: ", systemImage: "text")
            TextField("Enter text...", text: $text)
        }
    }
    
    var currentPbContent: some View {
        if let currentPbContentString {
            if currentPbContentString.isEmpty {
                return VStack {
                    Text("Current Clipboard Content").font(.title)
                    Text("No content in clipboard currently")
                }
            }
            
            return VStack {
                Text("Current Clipboard Content").font(.title)
                Text(currentPbContentString)
            }
        } else {
            return VStack {
                Text("Current Clipboard Content").font(.title)
                Text("No content in clipboard currently")
            }
        }
    }
    
    var copyButton: some View {
        // Copy button
        Button {
            // Get the general pasteboard object
            let pb = NSPasteboard.general
            
            // Clear the pasteboard
            pb.clearContents()
            
            pb.setString(self.text, forType: .string)
            
            currentPbContentString = NSPasteboard.general.string(forType: .string)
        } label: {
            HStack {
                Text("Copy")
                Image(systemName: "doc.on.doc")
            }
        }
    }
    
    var clearButton: some View {
        // Clear button
        Button {
            NSPasteboard.general.clearContents()
            currentPbContentString = NSPasteboard.general.string(forType: .string)
        } label: {
            HStack {
                Text("Clear PB")
                Image(systemName: "clear")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
