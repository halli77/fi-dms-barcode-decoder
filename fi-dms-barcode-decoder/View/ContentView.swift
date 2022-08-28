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
                Text("FI-DMS-Scanner")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    
                    
                    
                  
                
                
                
                    List {
                        
                            ForEach(vm.fields.sorted(by: <), id: \.key) { key, value in
                                HStack {
                                    Text("\(vm.typeOfField[key] ?? "Feld unbekannt"):")
                                        .fontWeight(.bold)
                                    Text("[\(key)]")
                                        .fontWeight(.thin)
                                    Spacer()
                                    Text("\(value)")
                                        .textSelection(.enabled)
                                }
                                
                                            
                            }

                    }.listStyle(.plain)
                
                
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
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(ScannerViewModel())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
