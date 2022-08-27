//
//  ScannerView.swift
//  fi-dms-barcode-decoder
//
//  Created by Michael Hallmann on 27.08.22.
//

import SwiftUI
import CarBode
import AVFoundation //import to access barcode types you want to scan


struct ScannerView: View {
    
    @State var vm: ScannerViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        // AVMetadataObject.ObjectType
        VStack {
            // Click to Toggle camera
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close Scanner")
                    }
                        
                    Spacer()
            
            CBScanner(
                supportBarcode: .constant([.code39, .pdf417]), //Set type of barcode you want to scan
                    scanInterval: .constant(1.0) //Event will trigger every 5 seconds
                ){
                    //When the scanner found a barcode
                    print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                    vm.updateBarcode(newBarcodeType: $0.type.rawValue, newBarcodeValue: $0.value)
//                    vm.barcodeValue = String($0.value)
//                    vm.barcodeType = $0.type.rawValue
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
        }
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        // ScannerView(vm: vm)
        EmptyView()
    }
}
