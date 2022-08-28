//
//  ScannerViewModel.swift
//  fi-dms-barcode-decoder
//
//  Created by Michael Hallmann on 27.08.22.
//

import Foundation
import AVFoundation 

 

class ScannerViewModel: ObservableObject {
    @Published var barcodeValue: String = ""
    @Published var barcodeType: String = ""
    @Published var fields: [String : String] = [:]
    @Published var torchLightIsOn: Bool = false
    @Published var cameraPosition = AVCaptureDevice.Position.back
    @Published var showTypeOfFields: Bool = false
    var typeOfField: [String : String] = [:]
    
    init() {
     
        
        // 1D
        typeOfField["1"] = "Pers.- oder Kontonr."
        typeOfField["2"] = "Kennz. Pers. (0) o. Konto (1)"
        typeOfField["3"] = "Bankleitzahl zu Konto"
        typeOfField["4"] = "DokTyp"
        typeOfField["5"] = "DokDatum"
        typeOfField["6"] = "man. Indizierung"
        
        // 2D
        typeOfField["010"] = "DOK_ID (SIZ)"
        typeOfField["011"] = "DokTyp"
        typeOfField["012"] = "Schlagwort-ID"
        typeOfField["013"] = "Erfasser"
        typeOfField["014"] = "DokDatum"
        typeOfField["015"] = "Bezug-Kennz."
        typeOfField["101"] = "PERS_NR"
        typeOfField["102"] = "Personennummer"
        typeOfField["111"] = "KONTO_ID"
        typeOfField["112"] = "Kontonr."
        typeOfField["113"] = "BLZ"
        typeOfField["115"] = "Block BLZ/Kontonr."
        typeOfField["116"] = "IBAN"
        typeOfField["117"] = "BIC"
        typeOfField["121"] = "VERBUND_ID"
        typeOfField["131"] = "AEND_GRUPPE"
        typeOfField["141"] = "GSPR_VGNG_ID"
        typeOfField["142"] = "GSPR_VGNG_NR"
        typeOfField["151"] = "VMGO_ID"
        typeOfField["152"] = "VMGO_NR"
        typeOfField["161"] = "VERTRAGS_ID"
        typeOfField["170"] = "AKTENBEREICH"
        typeOfField["171"] = "WABINDEXFELD1"
        typeOfField["172"] = "WABINDEXFELD2"

        

                    
        
        
        
    }
    
    func updateBarcode (newBarcodeType: String, newBarcodeValue: String) {
        self.barcodeType = newBarcodeType
        self.barcodeValue = newBarcodeValue
        
        if newBarcodeType == "org.iso.PDF417" {
            decode2D(value: newBarcodeValue)
        } else {
            decode1D(value: newBarcodeValue)
        }
    }
    
    func clearFields() {
        self.fields = [:]
    }
    
    func decode1D (value: String) {
        //aaaaaaaaaabcdddeeeeeef  22
        fields = [:]
        fields["1"] = mySubString(str: value, from: 1, len: 10)
        fields["2"] = mySubString(str: value, from: 11, len: 1)
        fields["3"] = mySubString(str: value, from: 12, len: 1)
        fields["4"] = mySubString(str: value, from: 13, len: 3)
        fields["5"] = mySubString(str: value, from: 16, len: 6)
        fields["6"] = mySubString(str: value, from: 22, len: 1)
        
    }
    
    func decode2D (value: String) {
        fields = [:]
        
        var cursor = 3 // ab 3. Stelle parsen
        
        while cursor < value.count - 3 {
            let feld = mySubString(str: value, from: cursor, len: 3)
            let laenge = Int(mySubString(str: value, from: cursor + 3, len: 2)) ?? 0
            let wert = mySubString(str: value, from: cursor + 5, len: laenge)
            fields[feld] = wert
            cursor = cursor + 5 + laenge
        }

    }
    
    // counting starts at 1 !!
    func mySubString(str: String, from: Int, len: Int) -> String {
        let start = str.index(str.startIndex, offsetBy: from - 1)
        let end = str.index(str.startIndex, offsetBy: from + len - 1)
        let range = start..<end

        return String(str[range])
    }
    
    
}
