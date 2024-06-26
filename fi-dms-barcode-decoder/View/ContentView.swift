//
//  ContentView.swift
//  fi-dms-barcode-decoder
//
//  Created by Michael Hallmann on 27.08.22.
//

import SwiftUI

struct ContentView: View {
    
    
    @EnvironmentObject private var vm: ScannerViewModel
    @State var showSheet: Bool = false
    
    var body: some View {
//        ZStack {
//            Color(.white)
//                .edgesIgnoringSafeArea(.all)
            
            
            VStack {

                if vm.fields.isEmpty {
                    VStack {
 
                        Text("Bitte Barcode scannen...")
                      

                    }
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color.blue.cornerRadius(10))
                    .shadow(color: .gray, radius: 20, x: 0, y: 0.8)
                        
                } else {
                    HStack {
                        Button {
                            vm.clearFields()
                        } label: {
                            Label("löschen", systemImage: "trash.circle.fill")
                        }
                    }
                    
                  
                     
                        List {
                            
                                ForEach(vm.fields.sorted(by: <), id: \.key) { key, value in
                                    HStack {
                                        Text("[\(key)]")
                                            .font(.caption)
                                        if vm.showTypeOfFields {
                                            Text("\(vm.typeOfField[key] ?? "???"):")
                                                .font(.caption)
                                        }
                                        Spacer()
                                        Text("\(value)")
                                            .fontWeight(.thin)
                                            .textSelection(.enabled)
                                    }
                                    
                                                
                                }

                        }.listStyle(.plain)
                        .onLongPressGesture(minimumDuration: 5) {
                            vm.showTypeOfFields.toggle()
                        }

                        
                     

                }
                
                
                    
                
                
                Spacer()
                
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("Scan Barcode")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(20)
                        .background(Color.accentColor.cornerRadius(10))
                    
                })

                .sheet(isPresented: $showSheet, content: {
                    ScannerView(vm: vm)
                })

                
                
            }.padding()
            
            
 //       }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(ScannerViewModel())
            .previewInterfaceOrientation(.portrait)
      
        }
    }
}
