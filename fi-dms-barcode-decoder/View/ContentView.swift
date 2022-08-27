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
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                
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

                }
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("Scan Barcode")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(20)
                        .background(Color.white.cornerRadius(10))
                })

                .sheet(isPresented: $showSheet, content: {
                    // DO NOT ADD CONDITIONAL LOGIC
                    ScannerView(vm: vm)
                })
//                Text("Typ: \(vm.barcodeType)")
//                Text("Wert: \(vm.barcodeValue)")
                
                
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
