//
//  ScannerView.swift
//  fi-dms-barcode-decoder
//
//  Created by Michael Hallmann on 27.08.22.
//

import SwiftUI
import CarBode
import AVFoundation 


struct ScannerView: View {
    
    @State var vm: ScannerViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // AVMetadataObject.ObjectType
        VStack {
            HStack {
                
                Button {
                    vm.torchLightIsOn.toggle()
                } label: {
                    Label("Licht", systemImage: "flashlight.on.fill")
                }
                
                Button {
                    if vm.cameraPosition == .back {
                        vm.cameraPosition = .front
                    } else {
                        vm.cameraPosition = .back
                    }
                } label: {
                    Label("Kamera", systemImage: "arrow.triangle.2.circlepath")
                }
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Schließen", systemImage: "xmark")
                }
            }
            .padding()
                   
                                
            Spacer()
            
            CBScanner(
                supportBarcode: .constant([.code39, .pdf417]),
                torchLightIsOn: $vm.torchLightIsOn,
                scanInterval: .constant(0.8),
                cameraPosition: $vm.cameraPosition,
                mockBarCode: .constant(BarcodeData(value:"1000102622104092211770", type: .code39))
                ){
                    //print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                    vm.updateBarcode(newBarcodeType: $0.type.rawValue, newBarcodeValue: $0.value)
                    presentationMode.wrappedValue.dismiss()
                }
                onDraw: {
                    // print("Preview View Size = \($0.cameraPreviewView.bounds)")
                    // print("Barcode Corners = \($0.corners)")
                    
                    //line width
                    let lineWidth = 2

                    //line color
                    let lineColor = UIColor.red

                    //Fill color with opacity
                    //You also can use UIColor.clear if you don't want to draw fill color
                    let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)
                    
                    //Draw box
                    $0.draw(lineWidth: CGFloat(lineWidth), lineColor: lineColor, fillColor: fillColor)
                }
                .padding()
        }
        .padding()
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(vm: ScannerViewModel())
        
    }
}
