//
//  fi_dms_barcode_decoderApp.swift
//  fi-dms-barcode-decoder
//
//  Created by Michael Hallmann on 27.08.22.
//

import SwiftUI

@main
struct fi_dms_barcode_decoderApp: App {
    @StateObject private var vm = ScannerViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}

